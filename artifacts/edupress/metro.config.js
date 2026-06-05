const { getDefaultConfig } = require("expo/metro-config");
const path = require("path");
const os = require("os");

const config = getDefaultConfig(__dirname);

config.cacheStores = [];

config.fileMapCacheDirectory = path.join(
  __dirname,
  "../../.metro-cache"
);

module.exports = config;
