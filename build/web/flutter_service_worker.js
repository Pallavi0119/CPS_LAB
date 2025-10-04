'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "926cedb0a36167f315ccfff32ee60017",
"assets/AssetManifest.bin.json": "8a7c0ad0182ef1af92184aa944601545",
"assets/AssetManifest.json": "1fd69d36a6b5b318278afb2e1b9dc3e4",
"assets/assets/images/1.png": "91f8eb5f0aea22623afda1f3081e9f41",
"assets/assets/images/10.png": "d9286a5a31c332b9991a3d02d19159e1",
"assets/assets/images/11.png": "cdc8f823cd3016348bcf85b90e0de00d",
"assets/assets/images/12.png": "e5a710e85f7db7f8325bf935a03d6f2f",
"assets/assets/images/13.png": "2198de305d8c051afa44a781a6602c4f",
"assets/assets/images/14.png": "53a9e556e6dd03569f6d34e5b9450fbf",
"assets/assets/images/15.png": "d5d14bf9536c0f3e53adae68c86c6d37",
"assets/assets/images/16.png": "23b97898afa2bf8cb1a8d6c11e412fb2",
"assets/assets/images/17.png": "596699a54a923267c24388c73083f86e",
"assets/assets/images/2.png": "5cd0a1015a02cbc5bd08500ec6485dc8",
"assets/assets/images/3.png": "7348abb20dbea22636f084643fc8e1f1",
"assets/assets/images/4.png": "21ed21723d7a79d8fc70ade5a7380b40",
"assets/assets/images/5.png": "a5ab43830f547a82f269d2695eb202f0",
"assets/assets/images/6.png": "b14bf6340b626e2d31436fe8664a255b",
"assets/assets/images/7.png": "95b38d575e855c143be816882199f069",
"assets/assets/images/8.png": "0048d93b27f81d2176ca9643d7345451",
"assets/assets/images/9.png": "d3e22a28dafcb928942a086f80615ebe",
"assets/assets/images/Actitvity%2520monitoring%2520sensor.png": "c04f1f3eec7a4240cb09b7d307fd0db1",
"assets/assets/images/ble%2520dev%2520kit.jpg": "a258f9da17afd3a14cd05bf3dfcddc46",
"assets/assets/images/ble%2520node.png": "05b49576b227702a646b284df5d18130",
"assets/assets/images/blegateway.png": "52b81742f2e9702c3e3c6dcc458d4fa3",
"assets/assets/images/bme680.png": "dc25d2fbc5708879d296d884cc9bf99d",
"assets/assets/images/buzzer.png": "ed25cfd76164c8678c555eeb386403c9",
"assets/assets/images/contact_bg.png": "b7ae014653370cf9c30b1d3daf85ce0b",
"assets/assets/images/dataloggerrender.png": "e670a91622fa7efba0168e98c19e9e3b",
"assets/assets/images/deploy.png": "42da2ebdfd198f7f127ea2529a64ef8f",
"assets/assets/images/deployment_bg.png": "9f6badb2bdd2aa586d14b3a3ebaf8e9c",
"assets/assets/images/github.png": "c67e3b6a7f573619abd30fbb5ea8330d",
"assets/assets/images/groove%2520shield.png": "1e4a3f1223c5cad7439e23ad95f5e484",
"assets/assets/images/halleffect.png": "d0eff744db2e03a7ece18b959aaebf38",
"assets/assets/images/home_bg.jpg": "2ccbc235e2d8e356844f7e13095079c8",
"assets/assets/images/IMPACT.png": "35bab0844f91588447ba2a492bf1dc2b",
"assets/assets/images/ir%2520sensor.png": "076f798e419a75e91771dd6d6174a16c",
"assets/assets/images/lis3dh.png": "970848dbd107e8a7bea3f96abc5c5d6b",
"assets/assets/images/ltr390.png": "751de5059b76e0bad292c3e32113339d",
"assets/assets/images/Lux.png": "5f2e728c424ba02af4bb70e98344abb4",
"assets/assets/images/memory.png": "718a347e58d9b82053c412b054974598",
"assets/assets/images/product_bg.png": "333b6eb30fdeb0757635c6d6c1c90a29",
"assets/assets/images/programmer.png": "7a22b1bc9cce440d12fd506ec5e42a87",
"assets/assets/images/relay.png": "2a26e1a16011fb6eea8ded6a5f9f4e38",
"assets/assets/images/stts751.png": "a5d7dd1368c7f00f9ee1b886b396b05d",
"assets/assets/images/tlv.png": "41b3c848a336ddc2a4b17048dae12fa1",
"assets/assets/images/vl5.png": "ed2dbebce3aba34d3def52e284dfd9d7",
"assets/assets/pdfs/ACTIVITY.pdf": "61aece1fa81339aae26da389d119eba1",
"assets/assets/pdfs/BLEKIT.pdf": "1ab2f3608f5ecb1897a7f112f5c2785c",
"assets/assets/pdfs/BLENODE.pdf": "26d65af1affa2ef996c3c1ce05b82656",
"assets/assets/pdfs/BLE_GATEWAY_Datasheet.pdf": "ee8ed470ad8381fb174f5a32b81d2d25",
"assets/assets/pdfs/BME680.pdf": "8a93a0e10033fc6f75ccce5ab6f3b8e7",
"assets/assets/pdfs/BUZZER.pdf": "d1cde0012f09d295a30db3974afdce58",
"assets/assets/pdfs/Data_logger_datasheet.pdf": "cbbfb973603e1de2f69079b4e65496e3",
"assets/assets/pdfs/FLASHTOOL.pdf": "e26a7e7de7144d04d469487c12f0c749",
"assets/assets/pdfs/GROOVE.pdf": "d77e48c9c42c8e71ee80b9be2caa444f",
"assets/assets/pdfs/HALL.pdf": "6511bf7d90548a1ea48bb00b08b7cb6b",
"assets/assets/pdfs/IR.pdf": "20a837f49b74e42c3124e6aca531f224",
"assets/assets/pdfs/LIS3DH.pdf": "e7a49584e82e7b580e7590bede66927b",
"assets/assets/pdfs/LUX.pdf": "d7fb03740f11683dabde814e6565f1d5",
"assets/assets/pdfs/RELAY.pdf": "f2798dce27a5e8e80c1f7befe642734e",
"assets/assets/pdfs/STTS751.pdf": "5dbb004b2dacd0a8dd24c1a30bd8377e",
"assets/assets/pdfs/TLV.pdf": "7444c5d59b95a038d497039591b0489d",
"assets/assets/pdfs/UVLTR.pdf": "54721d81322bbc5722aa58b98c35ad4a",
"assets/assets/pdfs/VL.pdf": "71b25200255c437b956bb1730a4e41a5",
"assets/assets/pdfs/W25QXX.pdf": "92ad44366c7ebd4c78c1b6a54d105559",
"assets/FontManifest.json": "5a32d4310a6f5d9a6b651e75ba0d7372",
"assets/fonts/MaterialIcons-Regular.otf": "79722cf5b0b309699e9c812fd0d602da",
"assets/NOTICES": "45c7fc39da0d3e3c7292bcff5f7e1f2f",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/flutter_map/lib/assets/flutter_map_logo.png": "208d63cc917af9713fc9572bd5c09362",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "15d54d142da2f2d6f2e90ed1d55121af",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "262525e2081311609d1fdab966c82bfc",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "269f971cec0d5dc864fe9ae080b19e23",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"flutter_bootstrap.js": "b24ec8a7909fcf748813be7298aeb9a9",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "f1c6eda84ffa40742aa9f76fb73d16df",
"/": "f1c6eda84ffa40742aa9f76fb73d16df",
"main.dart.js": "f0002641f207e827fb0deae77404d9b7",
"manifest.json": "ebf312e0ddf2070ac11082fba2ac8920",
"version.json": "e0f01185025df5ae543f19dca72325db"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
