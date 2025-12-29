# Books
A simple, minimal reading tracker.

Use it to track books you want to read or have read. That's about all it does. It's not a social network or a book review site.

## Usage
This Rails engine is intended to be used as a guest app in my [Toybox multi-app configuration](https://github.com/kylesmile/toybox-host-example). If you want to install it outside of that, you're on your own.

## Installation
If you are using the example repository, this engine is installed by default.

In the toybox app, run:
```shell
git submodule add https://github.com/kylesmile/toybox-books.git engines/books
bin/update_engine_node_modules
bundle install
yarn install
```

## Contributing
Contributions are welcome if they are aligned with the project vision and direction.

My goal is to keep this app simple and minimal, without adding the bloat found in many other reading trackers.

Below is a non-exhaustive list of features that are not in scope for this project. Pull requests that add these will be closed. If you want those features, feel free to create a fork.
* Book reviews
* Friend lists
* A news feed of friends' reviews or books friends are reading
* Book recommendations

These are some features that I may consider adding in the future. Pull requests for these and other features that fit with the project vision are welcome.
* A simple rating system, limited to "like" and "dislike"
* Stats on number of books read in a year (or a custom time period). Both total books and new reads.
  * An unobtrusive option to share stats on a social network
* Multiple "to read" and "read" lists
* Shareable links to book lists

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
