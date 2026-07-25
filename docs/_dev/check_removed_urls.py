#! /usr/bin/env python

"""Check for removed URLs and verify if redirects exist."""

import csv
import io
import sys
from pathlib import Path

BASE_URLS = Path("base/docs/urls.txt")
COMPARE_URLS = Path("compare/docs/urls.txt")
REDIRECTS = Path("compare/docs/redirects.txt")


def read_urls(path):
    return {
        line.strip()
        for line in path.read_text(encoding="utf-8").splitlines()
        if line.strip()
    }


def read_redirect_sources(path):
    sources = set()

    if not path.exists():
        return sources

    for raw_line in path.read_text(encoding="utf-8").splitlines():
        line = raw_line.strip()
        if not line or line.startswith("#"):
            continue

        fields = next(
            csv.reader(
                io.StringIO(line),
                delimiter=" ",
                quotechar='"',
                skipinitialspace=True,
            ),
            [],
        )
        if fields:
            sources.add(fields[0])

    return sources


def source_candidates_for_url(url):
    clean_path = url.strip()
    clean_path = clean_path.removeprefix("./")
    clean_path = clean_path.removeprefix("/")
    clean_path = clean_path.removesuffix(".html")
    clean_path = clean_path.rstrip("/")

    if not clean_path:
        return {"index.md"}

    # A removed dirhtml URL can map back to either a page file or an
    # index file. Directory-level redirects are stored with a trailing
    # slash, so include that form too.
    return {
        f"{clean_path}.md",
        f"{clean_path}/index.md",
        f"{clean_path}/",
    }


def main():
    if not BASE_URLS.exists():
        print(f"Error: Base URLs file not found at {BASE_URLS}")
        sys.exit(1)
    if not COMPARE_URLS.exists():
        print(f"Error: Compare URLs file not found at {COMPARE_URLS}")
        sys.exit(1)

    removed_urls = sorted(read_urls(BASE_URLS) - read_urls(COMPARE_URLS))
    redirect_sources = read_redirect_sources(REDIRECTS)

    missing_redirects = [
        url
        for url in removed_urls
        if source_candidates_for_url(url).isdisjoint(redirect_sources)
    ]

    if missing_redirects:
        print("The following URLs were removed without redirects:")
        print("\n".join(missing_redirects))
        print("Please ensure removed pages are redirected")
        sys.exit(1)

    if removed_urls:
        print("Removed URLs have redirects:")
        print("\n".join(removed_urls))


if __name__ == "__main__":
    main()
