cordova.define('cordova/plugin_list', function(require, exports, module) {
module.exports = [
    {
        "file": "plugins/cordova-plugin-native/www/native.js",
        "id": "cordova-plugin-native.Native",
        "pluginId": "cordova-plugin-native",
        "clobbers": [
            "Native"
        ]
    }
];
module.exports.metadata = 
// TOP OF METADATA
{
    "cordova-plugin-whitelist": "1.2.2",
    "cordova-plugin-native": "1.0.0-dev"
}
// BOTTOM OF METADATA
});