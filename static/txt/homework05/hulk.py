#!/usr/bin/env python3

from typing import Iterable, Iterator

import concurrent.futures
import hashlib
import os
import string
import sys

# Constants

ALPHABET = string.ascii_lowercase + string.digits

# Functions

def usage(exit_code: int=0):
    print('''Usage: hulk.py [-a ALPHABET -c CORES -l LENGTH -p PATH -s HASHES]
    -a ALPHABET Alphabet to use in permutations
    -c CORES    CPU Cores to use
    -l LENGTH   Length of permutations
    -p PREFIX   Prefix for all permutations
    -s HASHES   Path of hashes file''', file=sys.stderr)
    sys.exit(exit_code)

def sha1sum(s: str) -> str:
    ''' Compute SHA1 digest for given string.

    >>> sha1sum('a')
    '86f7e437faa5a7fce15d1ddcb9eaeaea377667b8'
    '''
    # TODO: Use the hashlib library to produce the SHA1 hex digest of the given
    # string.
    return ''

def permutations(length: int, alphabet: str=ALPHABET) -> Iterator[str]:
    ''' Recursively yield all permutations of alphabet up to given length.

    >>> for p in permutations(2, 'ab'): print(p)
    aa
    ab
    ba
    bb
    '''
    # TODO: Use yield to create a generator function that recursively produces
    # all the permutations of the given alphabet up to the provided length.
    yield ''

def flatten(sequence: Iterable[Iterable[str]]) -> Iterator[str]:
    ''' Flatten sequence of iterables.

    >>> for p in flatten([['a', 'b'], ['c', 'd']]): print(p)
    a
    b
    c
    d
    '''
    # TODO: Iterate through sequence and yield from each iterator in sequence.
    yield ''

def crack(hashes: set[str], length: int, alphabet: str=ALPHABET, prefix: str='') -> list[str]:
    ''' Return all password permutations of specified length that are in hashes
    by trying all possible permutations sequentially.

    >>> for p in crack({sha1sum(l) for l in 'abc'}, 1, 'abcd'): print(p)
    a
    b
    c
    '''
    # TODO: Return list comprehension that iterates over a sequence of
    # candidate permutations and checks if the sha1sum of each candidate is in
    # hashes.
    return []

def whack(arguments: tuple[set[str], int, str, str]) -> list[str]:
    ''' Call the crack function with the specified list of arguments

    >>> for p in whack([{sha1sum(l) for l in 'abc'}, 1, 'abcd', '']): print(p)
    a
    b
    c
    '''
    return []

def smash(hashes: set[str], length: int, alphabet: str=ALPHABET, prefix: str='', cores: int=1) -> Iterator[str]:
    ''' Return all password permutations of specified length that are in hashes
    by cracking subsets of all possible permutations concurrently.

    >>> for p in smash({sha1sum(l) for l in 'abc'}, 1, 'abcd'): print(p)
    a
    b
    c
    '''
    # TODO: Create generator expression with arguments to pass to whack and
    # then use ProcessPoolExecutor to apply whack to all items in expression.
    yield ''

# Main Execution

def main(arguments: list[str]=sys.argv[1:]) -> None:
    ''' Smashes given hashes to determine passwords with specified alphabet,
    length, and prefix.  Uses multiple cores (ie. processes) if specified.

    >>> main('-a abcdefg -l 2'.split())
    cg
    fg
    gg
    '''
    alphabet    = ALPHABET
    cores       = 1
    hashes_path = 'hulk.hashes'
    length      = 1
    prefix      = ''

    # TODO: Parse command line arguments

    # TODO: Load hashes set

    # TODO: Execute smash function

    # TODO: Print all found passwords

if __name__ == '__main__':
    main()

# vim: set sts=4 sw=4 ts=8 expandtab ft=python:
