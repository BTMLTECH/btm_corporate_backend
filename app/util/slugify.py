#!/usr/bin/env python3
# File: slugify.py
# Author: Oluwatobiloba Light
"""Slugify utility function"""
import re
import unicodedata


def slugify(title, max_length=60):
    STOPWORDS = {
        "and",
        "the",
        "in",
        "of",
        "on",
        "at",
        "a",
        "an",
        "to",
        "for",
        "with",
    }

    # Normalize and clean
    slug = unicodedata.normalize("NFKD", title)
    slug = slug.encode("ascii", "ignore").decode("ascii")
    slug = slug.lower()
    slug = re.sub(r"[^a-z0-9\s-]", "", slug)

    # Remove stopwords
    words = slug.split()
    words = [word for word in words if word not in STOPWORDS]
    slug = "-".join(words)

    # Remove multiple hyphens
    slug = re.sub(r"-+", "-", slug)

    # Trim to max length
    slug = slug[:max_length].rstrip("-")

    return slug
