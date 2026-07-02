# AGENTS.md — books

## Overview

A simple reading tracker. Track books you want to read, are reading, or have finished. No social features, no reviews.

## Stack

| Layer | Technology |
| ------- | ------------ |
| Framework | Ruby on Rails 8.1 (engine) |
| Database | PostgreSQL (via host shard: `books`) |
| Frontend | Hotwire (Turbo + Stimulus), Slim templates |

## Models

| Model | Description |
| ------- | ------------- |
| `User` | Account holder |
| `Book` | Book entry, unique per user+title+author |
| `BookList` | Collections: `to_read` or `read` |
| `BookListEntry` | Joins books to lists, optional `read_at` date |
| `Session` | Auth sessions |

## Key Files

| File | Purpose |
| ------ | --------- |
| `books.gemspec` | Engine gemspec |
| `config/routes.rb` | Engine routes |
| `lib/engine.rb` | Engine class (auto-mounted by host) |
| `test/dummy/` | Dummy Rails app for engine integration tests |

## Testing

- `bin/test` or `bin/rails test` runs from the engine directory
