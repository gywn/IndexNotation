#!/usr/bin/python
"""Help to calculate dependance of a symbol in Mathematica package
Example Usage:
    python dep.py --pretty \
                  --package-context IndexNotation \
                  Scope\`UniqueIndex unit/test/transform_rules/t-t.m etc.
For more info please run 'python dep.py -h'
"""
from __future__ import print_function
from pprint import pprint
from os.path import (expanduser, isfile, normpath, join)
import re

global PACKAGE_CONTEXT, PACKAGE_DIR

RE_COMMENT = re.compile(r'\(\*.*?\*\)', re.DOTALL)


def mma_path(path):
    return join(MMA_APP_PATH, PACKAGE_DIR, path)


def get_path(symbol):
    """Find the file which provides definition of symbol
    Input:
        symbol: like 'Scope`UniqueIndex', or a path 'Scope/UniqueIndex.m'
    Return:
        None: cannot find any file defining symbol
        str:  path to file defining symbol relative to MMA_APP_PATH
    """
    if isfile(mma_path(symbol)):
        return normpath(symbol)

    chain = symbol.split('`')

    if chain[0] == PACKAGE_CONTEXT:
        chain = chain[1:]

    paths = []
    path = '.'
    for m in chain:
        path += '/' + m
        paths += [path + '/init.m', path + '.m']

    for f in reversed(paths):
        if isfile(mma_path(f)):
            return normpath(f)


def fill_children(path, chdr_dict, symbols=None):
    """ Fill chdr_dict with children info
    Side Effect:
        Add files needed by 'path' into chdr_dict[path] (a set), if not
        undefined. If 'symbols' is not None, then use them as what 'path'
        should import.
    """
    if path in chdr_dict:
        return

    if symbols is None:
        f = RE_COMMENT.sub('', open(mma_path(path), 'r').read())
        symbols = set(re.findall(PACKAGE_CONTEXT + r'`(?:[\w]+`)*[\w]+', f) +
                      re.findall(r'<< *"' + PACKAGE_DIR + r'/([^"]+).m"', f))

    paths = [f for f in [get_path(s) for s in symbols] if f is not None]
    chdr_dict[path] = set(paths)

    for f in paths:
        fill_children(f, chdr_dict)


def get_descendants(path, chdr_dict):
    """All files recursively needed by 'path'"""

    core_set = set()
    boundary_set = set(chdr_dict[path])

    while len(boundary_set) > 0:
        f = boundary_set.pop()
        core_set.add(f)
        boundary_set |= chdr_dict[f]
        boundary_set -= core_set

    return core_set


def get_dep(symbols):
    """Find all files that are needed to define a set of symbols"""

    children = {}
    fill_children('IMPORT', children, set(symbols))

    descendants = {}
    for p in children:
        descendants[p] = get_descendants(p, children)

    return sorted(
        list(descendants['IMPORT']),
        key=lambda f: (len(descendants[f]), f)
    )


if __name__ == "__main__":
    import sys
    import argparse

    parser = argparse.ArgumentParser(description='Help to calculate dependance of a symbol in Mathematica package')

    parser.add_argument('-b', '--apps-dir',
                        metavar='$UserBaseDirectory/Applications',
                        default=expanduser('~/Library/Mathematica/Applications/'),
                        help='The directory storing all packages')

    parser.add_argument('-c', '--package-context',
                        metavar='PACKAGE_CONTEXT',
                        help='The context where the package lives')

    parser.add_argument('-d', '--package-dir',
                        metavar='PACKAGE_DIR',
                        help='The folder name of the package (same as package\'s context if omitted)')

    parser.add_argument('-p', '--pretty',
                        action='store_const',
                        const='<< "{0}"',
                        default='{0}',
                        help='Print in format that can be directly read by Mathematica')

    parser.add_argument('symbols',
                        nargs='+',
                        metavar='symbol')

    args = parser.parse_args(sys.argv[1:])
    if not args.package_context:
        parser.error('At least --package-context should be given.')

    MMA_APP_PATH = args.apps_dir
    PACKAGE_CONTEXT = args.package_context
    PACKAGE_DIR = args.package_dir or PACKAGE_CONTEXT

    for f in get_dep(args.symbols):
        print(args.pretty.format(join(PACKAGE_DIR, f)))
