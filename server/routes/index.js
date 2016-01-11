/*
 * the main route handler
 */

const express = require('express');
const router = express.Router();

const home = require('../controllers/home');
const error = require('../controllers/error');

// home
router.get('/', home);

// error on all other routes
router.get('*', error);

export default router;
