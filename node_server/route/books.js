const express = require("express");

const booksRoute = express.Router();

const { Books } = require("../models/books");

booksRoute.get("/api/books", async (req, res) => {
    try {
        const books = await Books.find({});
        res.json(books);
    } catch (e) {
        res.status(500).json({error: e.message});
    }
});

booksRoute.get("/api/books/:id", async (req, res) => {
    try {
        const bookId = req.params.id;
        const book = await Books.findById(bookId);
        if (book) {
          res.json(book);
        } else {
          res.status(404).json({ error: 'Book not found' });
        }
      } catch (error) {
        console.error('Error fetching book:', error);
        res.status(500).json({ error: 'Failed to fetch book' });
      }
});

module.exports = booksRoute;