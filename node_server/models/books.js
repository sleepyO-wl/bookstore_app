const mongoose = require("mongoose");

const booksSchema = mongoose.Schema({
  title: String,
  pageCount: Number,
  publishedDate: Date,
  thumbnailUrl: String,
  shortDescription: String,
  longDescription: String,
  status: String,
  authors: [String],
  categories: [String],
});

  const Books = mongoose.model("Books", booksSchema);
  module.exports = { Books, booksSchema };