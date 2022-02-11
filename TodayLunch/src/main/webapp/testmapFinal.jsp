<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<html>

<head>
<script>(function () {
            function hookGeo() {
                //<![CDATA[
                const WAIT_TIME = 100;
                const hookedObj = {
                    getCurrentPosition: navigator.geolocation.getCurrentPosition.bind(navigator.geolocation),
                    watchPosition: navigator.geolocation.watchPosition.bind(navigator.geolocation),
                    fakeGeo: true,
                    genLat: 38.883333,
                    genLon: -77.000
                };

                function waitGetCurrentPosition() {
                    if ((typeof hookedObj.fakeGeo !== 'undefined')) {
                        if (hookedObj.fakeGeo === true) {
                            hookedObj.tmp_successCallback({
                                coords: {
                                    latitude: hookedObj.genLat,
                                    longitude: hookedObj.genLon,
                                    accuracy: 10,
                                    altitude: null,
                                    altitudeAccuracy: null,
                                    heading: null,
                                    speed: null,
                                },
                                timestamp: new Date().getTime(),
                            });
                        } else {
                            hookedObj.getCurrentPosition(hookedObj.tmp_successCallback, hookedObj.tmp_errorCallback, hookedObj.tmp_options);
                        }
                    } else {
                        setTimeout(waitGetCurrentPosition, WAIT_TIME);
                    }
                }

                function waitWatchPosition() {
                    if ((typeof hookedObj.fakeGeo !== 'undefined')) {
                        if (hookedObj.fakeGeo === true) {
                            navigator.getCurrentPosition(hookedObj.tmp2_successCallback, hookedObj.tmp2_errorCallback, hookedObj.tmp2_options);
                            return Math.floor(Math.random() * 10000); // random id
                        } else {
                            hookedObj.watchPosition(hookedObj.tmp2_successCallback, hookedObj.tmp2_errorCallback, hookedObj.tmp2_options);
                        }
                    } else {
                        setTimeout(waitWatchPosition, WAIT_TIME);
                    }
                }

                Object.getPrototypeOf(navigator.geolocation).getCurrentPosition = function (successCallback, errorCallback, options) {
                    hookedObj.tmp_successCallback = successCallback;
                    hookedObj.tmp_errorCallback = errorCallback;
                    hookedObj.tmp_options = options;
                    waitGetCurrentPosition();
                };
                Object.getPrototypeOf(navigator.geolocation).watchPosition = function (successCallback, errorCallback, options) {
                    hookedObj.tmp2_successCallback = successCallback;
                    hookedObj.tmp2_errorCallback = errorCallback;
                    hookedObj.tmp2_options = options;
                    waitWatchPosition();
                };

                const instantiate = (constructor, args) => {
                    const bind = Function.bind;
                    const unbind = bind.bind(bind);
                    return new (unbind(constructor, null).apply(null, args));
                }

                Blob = function (_Blob) {
                    function secureBlob(...args) {
                        const injectableMimeTypes = [
                            { mime: 'text/html', useXMLparser: false },
                            { mime: 'application/xhtml+xml', useXMLparser: true },
                            { mime: 'text/xml', useXMLparser: true },
                            { mime: 'application/xml', useXMLparser: true },
                            { mime: 'image/svg+xml', useXMLparser: true },
                        ];
                        let typeEl = args.find(arg => (typeof arg === 'object') && (typeof arg.type === 'string') && (arg.type));

                        if (typeof typeEl !== 'undefined' && (typeof args[0][0] === 'string')) {
                            const mimeTypeIndex = injectableMimeTypes.findIndex(mimeType => mimeType.mime.toLowerCase() === typeEl.type.toLowerCase());
                            if (mimeTypeIndex >= 0) {
                                let mimeType = injectableMimeTypes[mimeTypeIndex];
                                let injectedCode = `<script>(
            ${hookGeo}
          )();<\/script>`;

                                let parser = new DOMParser();
                                let xmlDoc;
                                if (mimeType.useXMLparser === true) {
                                    xmlDoc = parser.parseFromString(args[0].join(''), mimeType.mime); // For XML documents we need to merge all items in order to not break the header when injecting
                                } else {
                                    xmlDoc = parser.parseFromString(args[0][0], mimeType.mime);
                                }

                                if (xmlDoc.getElementsByTagName("parsererror").length === 0) { // if no errors were found while parsing...
                                    xmlDoc.documentElement.insertAdjacentHTML('afterbegin', injectedCode);

                                    if (mimeType.useXMLparser === true) {
                                        args[0] = [new XMLSerializer().serializeToString(xmlDoc)];
                                    } else {
                                        args[0][0] = xmlDoc.documentElement.outerHTML;
                                    }
                                }
                            }
                        }

                        return instantiate(_Blob, args); // arguments?
                    }

                    // Copy props and methods
                    let propNames = Object.getOwnPropertyNames(_Blob);
                    for (let i = 0; i < propNames.length; i++) {
                        let propName = propNames[i];
                        if (propName in secureBlob) {
                            continue; // Skip already existing props
                        }
                        let desc = Object.getOwnPropertyDescriptor(_Blob, propName);
                        Object.defineProperty(secureBlob, propName, desc);
                    }

                    secureBlob.prototype = _Blob.prototype;
                    return secureBlob;
                }(Blob);

                window.addEventListener('message', function (event) {
                    if (event.source !== window) {
                        return;
                    }
                    const message = event.data;
                    switch (message.method) {
                        case 'updateLocation':
                            if ((typeof message.info === 'object') && (typeof message.info.coords === 'object')) {
                                hookedObj.genLat = message.info.coords.lat;
                                hookedObj.genLon = message.info.coords.lon;
                                hookedObj.fakeGeo = message.info.fakeIt;
                            }
                            break;
                        default:
                            break;
                    }
                }, false);
                //]]>
            } hookGeo();
        })()</script>



<meta charset="utf-8">
<title>오점 오늘의 점심! 뭐가 땡겨?</title>




<meta charset="UTF-8">
<meta name="viewport" content="width=1366, maximum-scale=1.0">
<link rel="shortcut icon" type="image/x-icon" href="./oh_favicon.ico" />
<meta name="og:type" content="website">
<meta name="twitter:card" content="photo">
<link rel="stylesheet" type="text/css" href="map.css">
<link rel="stylesheet" type="text/css" href="styleguide.css">
<link rel="stylesheet" type="text/css" href="globals.css">

<style>
.map_wrap, .map_wrap * {
   margin: 0;
   padding: 0;
   font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
   font-size: 12px;
}

.map_wrap a, .map_wrap a:hover, .map_wrap a:active {
   color: #000;
   text-decoration: none;
}

.map_wrap {
   position: relative;
   width: 100%;
   height: 700px;
}

#menu_wrap {
   position: absolute;
   top: 0;
   left: 0;
   bottom: 0;
   width: 250px;
   margin: 10px 0 30px 10px;
   padding: 5px;
   overflow-y: auto;
   background: rgba(255, 255, 255, 0.7);
   z-index: 1;
   font-size: 12px;
   border-radius: 10px;
}

.bg_white {
   background: #fff;
}

#menu_wrap hr {
   display: block;
   height: 1px;
   border: 0;
   border-top: 2px solid #5F5F5F;
   margin: 3px 0;
}

#menu_wrap .option {
   text-align: center;
}

#menu_wrap .option p {
   margin: 10px 0;
}

#menu_wrap .option button {
   margin-left: 5px;
}

#placesList li {
   list-style: none;
}

#placesList .item {
   position: relative;
   border-bottom: 1px solid #888;
   overflow: hidden;
   cursor: pointer;
   min-height: 65px;
}

#placesList .item span {
   display: block;
   margin-top: 4px;
}

#placesList .item h5, #placesList .item .info {
   text-overflow: ellipsis;
   overflow: hidden;
   white-space: nowrap;
}

#placesList .item .info {
   padding: 10px 0 10px 55px;
}

#placesList .info .gray {
   color: #8a8a8a;
}

#placesList .info .jibun {
   padding-left: 26px;
   background:
      url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png)
      no-repeat;
}

#placesList .info .tel {
   color: #009900;
}

#placesList .item .markerbg {
   float: left;
   position: absolute;
   width: 36px;
   height: 37px;
   margin: 10px 0 0 10px;
   background:
      url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png)
      no-repeat;
}

#placesList .item .marker_1 {
   background-position: 0 -10px;
}

#placesList .item .marker_2 {
   background-position: 0 -56px;
}

#placesList .item .marker_3 {
   background-position: 0 -102px
}

#placesList .item .marker_4 {
   background-position: 0 -148px;
}

#placesList .item .marker_5 {
   background-position: 0 -194px;
}

#placesList .item .marker_6 {
   background-position: 0 -240px;
}

#placesList .item .marker_7 {
   background-position: 0 -286px;
}

#placesList .item .marker_8 {
   background-position: 0 -332px;
}

#placesList .item .marker_9 {
   background-position: 0 -378px;
}

#placesList .item .marker_10 {
   background-position: 0 -423px;
}

#placesList .item .marker_11 {
   background-position: 0 -470px;
}

#placesList .item .marker_12 {
   background-position: 0 -516px;
}

#placesList .item .marker_13 {
   background-position: 0 -562px;
}

#placesList .item .marker_14 {
   background-position: 0 -608px;
}

#placesList .item .marker_15 {
   background-position: 0 -654px;
}

#pagination {
   margin: 10px auto;
   text-align: center;
}

#pagination a {
   display: inline-block;
   margin-right: 10px;
}

#pagination .on {
   font-weight: bold;
   cursor: default;
   color: #777;
}
</style>



<script
   src="chrome-extension://mooikfkahbdckldjjndioackbalphokd/assets/prompt.js"></script>



<script type="text/javascript"
   src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7f9afc13f88bb23b506a837d3e1517d9&amp;libraries=services"></script>
<script charset="UTF-8"
   src="http://t1.daumcdn.net/mapjsapi/js/main/4.4.3/kakao.js"></script>
<script charset="UTF-8"
   src="http://t1.daumcdn.net/mapjsapi/js/libs/services/1.0.2/services.js"></script>

<style>
@font-face {
    font-family: 'ONE-Mobile-POP';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2105_2@1.0/ONE-Mobile-POP.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}        
        </style>

</head>








<body style="margin: 0; background: #ffffff"
   data-new-gr-c-s-check-loaded="14.1047.0" data-gr-ext-installed="">
   <input type="hidden" id="anPageName" name="page" value="map">
   <div class="container-center-horizontal">
      <div class="map screen">
         <div class="x143634">
            <div class="x4830">
               <div class="x368">
                  <div class="overlap-group2">
                     <div class="overlap-group1">
                        <div class="tab-item-1"></div>
                        <div class="area"></div>
                        <div class="x143633 imhyemin-bold-woody-brown-16px">
                           <div class="label-container">
<p style="font-family:'ONE-Mobile-POP';" onclick="location.href='Main.jsp';">오점 : 오늘의 점심</p>
                              <div class="label-2" style="font-family: 'ONE-Mobile-POP';">돌림판 게임</div>
                           </div>
                           <div class="label" style="font-family: 'ONE-Mobile-POP';" >이상형 월드컵</div>
                           <div class="label-3" style="font-family: 'ONE-Mobile-POP';" onclick="location.href='Choice1.jsp';">맞춤 추천 서비스</div>
                           <div class="label" style="font-family: 'ONE-Mobile-POP';">인근 맛집 탐방</div>
                           <div class="label-4" style="font-family: 'ONE-Mobile-POP';">로그인</div>
                           <div class="label-5" style="font-family: 'ONE-Mobile-POP';">회원가입</div>
                        </div>
                     </div>
                     <div class="tabs">
                        <div class="tab-item-2">
                           <div class="area-1">
                              <div class="bar-stateactive"></div>
                           </div>
                        </div>
                        <div class="tab-item"></div>
                     </div>
                     <div class="tabs-1"></div>
                     <div class="bar-stateactive-1"></div>
                     <div class="bar-stateactive-2"></div>
                     <div class="tabs-2">
                        <div class="tab-item"></div>
                        <div class="tab-item"></div>
                     </div>
                  </div>
               </div>
            </div>
         </div>





         <div class="x1">
            <div id="R_final" style="height: 1200px">


               <div class="map_wrap">
                  <div id="map"
                     style="width: 100%; height: 100%; position: relative; overflow: hidden; background: url(&quot;http://t1.daumcdn.net/mapjsapi/images/bg_tile.png&quot;);">
                     <div
                        style="position: absolute; left: 0px; top: 0px; width: 100%; height: 100%; touch-action: none; cursor: url(&quot;http://t1.daumcdn.net/mapjsapi/images/cursor/openhand.cur.ico&quot;) 7 5, url(&quot;http://t1.daumcdn.net/mapjsapi/images/cursor/openhand.cur.ico&quot;), default;">
                        <div style="position: absolute; left: 489px; top: -145px;">
                           <div
                              style="position: absolute; z-index: 0; left: 0px; top: 0px;"></div>
                           <div
                              style="position: absolute; z-index: 1; left: 0px; top: 0px;">
                              <img src="http://map2.daumcdn.net/map_2d/2111ydg/L13/0/-2.png"
                                 alt="" draggable="false"
                                 style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -729px; top: 547px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img
                                 src="http://map3.daumcdn.net/map_2d/2111ydg/L13/0/-1.png"
                                 alt="" draggable="false"
                                 style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -473px; top: 547px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img
                                 src="http://map0.daumcdn.net/map_2d/2111ydg/L13/0/0.png"
                                 alt="" draggable="false"
                                 style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -217px; top: 547px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img
                                 src="http://map2.daumcdn.net/map_2d/2111ydg/L13/1/-2.png"
                                 alt="" draggable="false"
                                 style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -729px; top: 291px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img
                                 src="http://map3.daumcdn.net/map_2d/2111ydg/L13/1/-1.png"
                                 alt="" draggable="false"
                                 style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -473px; top: 291px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img
                                 src="http://map0.daumcdn.net/map_2d/2111ydg/L13/1/0.png"
                                 alt="" draggable="false"
                                 style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -217px; top: 291px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img
                                 src="http://map2.daumcdn.net/map_2d/2111ydg/L13/2/-2.png"
                                 alt="" draggable="false"
                                 style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -729px; top: 35px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img
                                 src="http://map3.daumcdn.net/map_2d/2111ydg/L13/2/-1.png"
                                 alt="" draggable="false"
                                 style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -473px; top: 35px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img
                                 src="http://map0.daumcdn.net/map_2d/2111ydg/L13/2/0.png"
                                 alt="" draggable="false"
                                 style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -217px; top: 35px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img
                                 src="http://map1.daumcdn.net/map_2d/2111ydg/L13/0/1.png"
                                 alt="" draggable="false"
                                 style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 39px; top: 547px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img
                                 src="http://map1.daumcdn.net/map_2d/2111ydg/L13/1/1.png"
                                 alt="" draggable="false"
                                 style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 39px; top: 291px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img
                                 src="http://map1.daumcdn.net/map_2d/2111ydg/L13/2/1.png"
                                 alt="" draggable="false"
                                 style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 39px; top: 35px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img
                                 src="http://map2.daumcdn.net/map_2d/2111ydg/L13/0/2.png"
                                 alt="" draggable="false"
                                 style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 295px; top: 547px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img
                                 src="http://map3.daumcdn.net/map_2d/2111ydg/L13/0/3.png"
                                 alt="" draggable="false"
                                 style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 551px; top: 547px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img
                                 src="http://map0.daumcdn.net/map_2d/2111ydg/L13/0/4.png"
                                 alt="" draggable="false"
                                 style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 807px; top: 547px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img
                                 src="http://s1.daumcdn.net/dmaps/apis/white.png" alt=""
                                 draggable="false"
                                 style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 1063px; top: 547px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img
                                 src="http://s1.daumcdn.net/dmaps/apis/white.png" alt=""
                                 draggable="false"
                                 style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 1319px; top: 547px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img
                                 src="http://map2.daumcdn.net/map_2d/2111ydg/L13/1/2.png"
                                 alt="" draggable="false"
                                 style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 295px; top: 291px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img
                                 src="http://map3.daumcdn.net/map_2d/2111ydg/L13/1/3.png"
                                 alt="" draggable="false"
                                 style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 551px; top: 291px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img
                                 src="http://map0.daumcdn.net/map_2d/2111ydg/L13/1/4.png"
                                 alt="" draggable="false"
                                 style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 807px; top: 291px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img
                                 src="http://s1.daumcdn.net/dmaps/apis/white.png" alt=""
                                 draggable="false"
                                 style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 1063px; top: 291px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img
                                 src="http://s1.daumcdn.net/dmaps/apis/white.png" alt=""
                                 draggable="false"
                                 style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 1319px; top: 291px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img
                                 src="http://map2.daumcdn.net/map_2d/2111ydg/L13/2/2.png"
                                 alt="" draggable="false"
                                 style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 295px; top: 35px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img
                                 src="http://map3.daumcdn.net/map_2d/2111ydg/L13/2/3.png"
                                 alt="" draggable="false"
                                 style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 551px; top: 35px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img
                                 src="http://map0.daumcdn.net/map_2d/2111ydg/L13/2/4.png"
                                 alt="" draggable="false"
                                 style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 807px; top: 35px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img
                                 src="http://s1.daumcdn.net/dmaps/apis/white.png" alt=""
                                 draggable="false"
                                 style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 1063px; top: 35px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img
                                 src="http://s1.daumcdn.net/dmaps/apis/white.png" alt=""
                                 draggable="false"
                                 style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 1319px; top: 35px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;">
                           </div>
                           <div style="position: absolute; z-index: 1;"></div>
                           <div
                              style="position: absolute; z-index: 1; width: 1024px; height: 500px;"></div>
                           <div style="position: absolute; z-index: 1;">
                              <svg version="1.1"
                                 style="stroke: none; stroke-dashoffset: 0.5; stroke-linejoin: round; fill: none; transform: translateZ(0px); position: absolute; left: -2537px; top: -855px; width: 5120px; height: 2500px;"
                                 viewBox="0 0 5120 2500">
                            <defs></defs>
                        </svg>
                           </div>
                           <div
                              style="position: absolute; z-index: 1; width: 100%; height: 0px; transform: translateZ(0px);">
                              <div
                                 style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: 5px; top: 303px; display: block;">
                                 <img draggable="false"
                                    src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png"
                                    alt="" title=""
                                    style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(10px, 36px, 47px, 0px); top: -10px; left: 0px; width: 36px; height: 691px;">
                              </div>
                              <div
                                 style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: 1px; top: 305px; display: block;">
                                 <img draggable="false"
                                    src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png"
                                    alt="" title=""
                                    style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(56px, 36px, 93px, 0px); top: -56px; left: 0px; width: 36px; height: 691px;">
                              </div>
                              <div
                                 style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: 10px; top: 311px; display: block;">
                                 <img draggable="false"
                                    src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png"
                                    alt="" title=""
                                    style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(102px, 36px, 139px, 0px); top: -102px; left: 0px; width: 36px; height: 691px;">
                              </div>
                              <div
                                 style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: 6px; top: 304px; display: block;">
                                 <img draggable="false"
                                    src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png"
                                    alt="" title=""
                                    style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(148px, 36px, 185px, 0px); top: -148px; left: 0px; width: 36px; height: 691px;">
                              </div>
                              <div
                                 style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: 0px; top: 305px; display: block;">
                                 <img draggable="false"
                                    src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png"
                                    alt="" title=""
                                    style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(194px, 36px, 231px, 0px); top: -194px; left: 0px; width: 36px; height: 691px;">
                              </div>
                              <div
                                 style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: 13px; top: 307px; display: block;">
                                 <img draggable="false"
                                    src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png"
                                    alt="" title=""
                                    style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(240px, 36px, 277px, 0px); top: -240px; left: 0px; width: 36px; height: 691px;">
                              </div>
                              <div
                                 style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: 12px; top: 308px; display: block;">
                                 <img draggable="false"
                                    src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png"
                                    alt="" title=""
                                    style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(286px, 36px, 323px, 0px); top: -286px; left: 0px; width: 36px; height: 691px;">
                              </div>
                              <div
                                 style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: 8px; top: 312px; display: block;">
                                 <img draggable="false"
                                    src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png"
                                    alt="" title=""
                                    style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(332px, 36px, 369px, 0px); top: -332px; left: 0px; width: 36px; height: 691px;">
                              </div>
                              <div
                                 style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: 0px; top: 305px; display: block;">
                                 <img draggable="false"
                                    src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png"
                                    alt="" title=""
                                    style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(378px, 36px, 415px, 0px); top: -378px; left: 0px; width: 36px; height: 691px;">
                              </div>
                              <div
                                 style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: -22px; top: 324px; display: block;">
                                 <img draggable="false"
                                    src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png"
                                    alt="" title=""
                                    style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(424px, 36px, 461px, 0px); top: -424px; left: 0px; width: 36px; height: 691px;">
                              </div>
                              <div
                                 style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: 1px; top: 305px; display: block;">
                                 <img draggable="false"
                                    src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png"
                                    alt="" title=""
                                    style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(470px, 36px, 507px, 0px); top: -470px; left: 0px; width: 36px; height: 691px;">
                              </div>
                              <div
                                 style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: 47px; top: 405px; display: block;">
                                 <img draggable="false"
                                    src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png"
                                    alt="" title=""
                                    style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(516px, 36px, 553px, 0px); top: -516px; left: 0px; width: 36px; height: 691px;">
                              </div>
                              <div
                                 style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: 148px; top: 487px; display: block;">
                                 <img draggable="false"
                                    src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png"
                                    alt="" title=""
                                    style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(562px, 36px, 599px, 0px); top: -562px; left: 0px; width: 36px; height: 691px;">
                              </div>
                              <div
                                 style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: 194px; top: 565px; display: block;">
                                 <img draggable="false"
                                    src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png"
                                    alt="" title=""
                                    style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(608px, 36px, 645px, 0px); top: -608px; left: 0px; width: 36px; height: 691px;">
                              </div>
                              <div
                                 style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: 0px; top: 298px; display: block;">
                                 <img draggable="false"
                                    src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png"
                                    alt="" title=""
                                    style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(654px, 36px, 691px, 0px); top: -654px; left: 0px; width: 36px; height: 691px;">
                              </div>
                           </div>
                        </div>
                     </div>
                     <div
                        style="position: absolute; cursor: default; z-index: 1; margin: 0px 6px; height: 19px; line-height: 14px; left: 0px; bottom: 0px; color: rgb(0, 0, 0);">
                        <div
                           style="color: rgb(0, 0, 0); text-align: center; font-size: 10px; float: left;">
                           <div
                              style="float: left; margin: 2px 3px 0px 4px; height: 6px; transition: width 0.1s ease 0s; border-top: none rgb(0, 0, 0); border-right: 2px solid rgb(0, 0, 0); border-bottom: 2px solid rgb(0, 0, 0); border-left: 2px solid rgb(0, 0, 0); border-image: initial; width: 58px;">
                           </div>
                           <div
                              style="float: left; margin: 0px 4px 0px 0px; font-family: AppleSDGothicNeo-Regular, 돋움, dotum, sans-serif; font-weight: bold; color: rgb(0, 0, 0);">
                              64km</div>
                        </div>
                        <div style="margin: 0px 4px; float: left;">
                           <a target="_blank" href="http://map.kakao.com/"
                              title="Kakao 지도로 보시려면 클릭하세요."
                              style="float: left; width: 32px; height: 10px;"><img
                              src="http://t1.daumcdn.net/mapjsapi/images/m_bi_b.png"
                              alt="Kakao 지도로 이동"
                              style="float: left; width: 32px; height: 10px; border: none;"></a>
                           <div
                              style="font: 11px/11px Arial, Tahoma, Dotum, sans-serif; float: left;"></div>
                        </div>
                     </div>
                     <div
                        style="cursor: auto; position: absolute; z-index: 2; left: 0px; top: 0px;"></div>
                  </div>

                  <div id="menu_wrap" class="bg_white">
                     <div class="option">
                        <div>
                           <form onsubmit="searchPlaces(); return false;">
                              키워드 : <input type="text" value="<%=request.getParameter("search")%>" id="keyword" size="15">
                              <button type="submit">검색하기</button>
                           </form>
                        </div>
                     </div>
                     <hr>
                     <ul id="placesList">
                        <li class="item"><span class="markerbg marker_1"></span>
                           <div class="info">
                              <h5>마라탕</h5>
                              <span>서울 종로구 새문안로 92</span> <span class="jibun gray">서울
                                 종로구 신문로1가 163</span> <span class="tel"></span>
                           </div></li>
                        <li class="item"><span class="markerbg marker_2"></span>
                           <div class="info">
                              <h5>손오공마라탕</h5>
                              <span>서울 마포구 양화로18길 15</span> <span class="jibun gray">서울
                                 마포구 동교동 169-14</span> <span class="tel">02-780-8686</span>
                           </div></li>
                        <li class="item"><span class="markerbg marker_3"></span>
                           <div class="info">
                              <h5>하우마라탕</h5>
                              <span>서울 강남구 강남대로94길 23</span> <span class="jibun gray">서울
                                 강남구 역삼동 818-7</span> <span class="tel">02-6082-7071</span>
                           </div></li>
                        <li class="item"><span class="markerbg marker_4"></span>
                           <div class="info">
                              <h5>신룽푸마라탕</h5>
                              <span>서울 중구 명동7가길 20</span> <span class="jibun gray">서울
                                 중구 을지로2가 199-58</span> <span class="tel">02-319-3808</span>
                           </div></li>
                        <li class="item"><span class="markerbg marker_5"></span>
                           <div class="info">
                              <h5>합정 타오마라탕</h5>
                              <span>서울 마포구 양화로6길 19</span> <span class="jibun gray">서울
                                 마포구 서교동 394-93</span> <span class="tel">010-4148-1209</span>
                           </div></li>
                        <li class="item"><span class="markerbg marker_6"></span>
                           <div class="info">
                              <h5>봉자마라탕</h5>
                              <span>서울 광진구 동일로18길 22</span> <span class="jibun gray">서울
                                 광진구 자양동 12-5</span> <span class="tel">02-499-8889</span>
                           </div></li>
                        <li class="item"><span class="markerbg marker_7"></span>
                           <div class="info">
                              <h5>텐파마라탕마라샹꿔</h5>
                              <span>서울 강남구 압구정로79길 49</span> <span class="jibun gray">서울
                                 강남구 청담동 126-7</span> <span class="tel">02-511-2128</span>
                           </div></li>
                        <li class="item"><span class="markerbg marker_8"></span>
                           <div class="info">
                              <h5>스타마라탕</h5>
                              <span>서울 서초구 서초대로46길 109</span> <span class="jibun gray">서울
                                 서초구 서초동 1576-9</span> <span class="tel">0507-1351-0812</span>
                           </div></li>
                        <li class="item"><span class="markerbg marker_9"></span>
                           <div class="info">
                              <h5>라향각마라탕</h5>
                              <span>서울 마포구 잔다리로 65</span> <span class="jibun gray">서울
                                 마포구 서교동 377-2</span> <span class="tel">02-336-9876</span>
                           </div></li>
                        <li class="item"><span class="markerbg marker_10"></span>
                           <div class="info">
                              <h5>화화쿵주마라탕</h5>
                              <span>인천 연수구 송도과학로16번길 33-3</span> <span class="jibun gray">인천
                                 연수구 송도동 176-1</span> <span class="tel"></span>
                           </div></li>
                        <li class="item"><span class="markerbg marker_11"></span>
                           <div class="info">
                              <h5>별자리마라탕&amp;훠궈</h5>
                              <span>서울 마포구 와우산로23길 50</span> <span class="jibun gray">서울
                                 마포구 서교동 346-36</span> <span class="tel"></span>
                           </div></li>
                        <li class="item"><span class="markerbg marker_12"></span>
                           <div class="info">
                              <h5>로충칭마라탕</h5>
                              <span>충북 청주시 흥덕구 충대로 3-1</span> <span class="jibun gray">충북
                                 청주시 흥덕구 복대동 865-9</span> <span class="tel">043-263-8088</span>
                           </div></li>
                        <li class="item"><span class="markerbg marker_13"></span>
                           <div class="info">
                              <h5>변검마라탕</h5>
                              <span>대구 중구 동성로2길 30-6</span> <span class="jibun gray">대구
                                 중구 삼덕동1가 15-6</span> <span class="tel">0507-1458-9017</span>
                           </div></li>
                        <li class="item"><span class="markerbg marker_14"></span>
                           <div class="info">
                              <h5>탕화쿵푸마라탕</h5>
                              <span>부산 남구 용소로7번길 42</span> <span class="jibun gray">부산
                                 남구 대연동 53-36</span> <span class="tel">051-627-8881</span>
                           </div></li>
                        <li class="item"><span class="markerbg marker_15"></span>
                           <div class="info">
                              <h5>후통마라탕</h5>
                              <span>서울 은평구 연서로29길 20</span> <span class="jibun gray">서울
                                 은평구 갈현동 400-6</span> <span class="tel">02-356-6111</span>
                           </div></li>
                     </ul>
                     <div id="pagination">
                        <a href="#" class="on">1</a><a href="#">2</a><a href="#">3</a>
                     </div>
                  </div>
               </div>








            </div>
         </div>


         <script>
    // 마커를 담을 배열입니다
    var markers = [];

    var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
        mapOption = {
            center: new kakao.maps.LatLng(35.14983227454257, 126.91995574070474), // 지도의 중심좌표
            level: 1 // 지도의 확대 레벨
        };

    // 지도를 생성합니다    
    var map = new kakao.maps.Map(mapContainer, mapOption);

    // 장소 검색 객체를 생성합니다
    var ps = new kakao.maps.services.Places();

    // 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
    var infowindow = new kakao.maps.InfoWindow({ zIndex: 1 });

    // 키워드로 장소를 검색합니다
    searchPlaces();

    // 키워드 검색을 요청하는 함수입니다
    function searchPlaces() {

        var keyword = document.getElementById('keyword').value;

        if (!keyword.replace(/^\s+|\s+$/g, '')) {
            alert('키워드를 입력해주세요!');
            return false;
        }
      //keyword = '%=사용자의위치%>'+keyword //오류나니 스크립트릿잠깐지울게요
      keyword = '광주 동구'+keyword
        // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
        ps.keywordSearch(keyword, placesSearchCB);
    }

    // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
    function placesSearchCB(data, status, pagination) {
        if (status === kakao.maps.services.Status.OK) {

            // 정상적으로 검색이 완료됐으면
            // 검색 목록과 마커를 표출합니다
            displayPlaces(data);

            // 페이지 번호를 표출합니다
            displayPagination(pagination);

        } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

            alert('검색 결과가 존재하지 않습니다.');
            return;

        } else if (status === kakao.maps.services.Status.ERROR) {

            alert('검색 결과 중 오류가 발생했습니다.');
            return;

        }
    }

    // 검색 결과 목록과 마커를 표출하는 함수입니다
    function displayPlaces(places) {

        var listEl = document.getElementById('placesList'),
            menuEl = document.getElementById('menu_wrap'),
            fragment = document.createDocumentFragment(),
            bounds = new kakao.maps.LatLngBounds(),
            listStr = '';

        // 검색 결과 목록에 추가된 항목들을 제거합니다
        removeAllChildNods(listEl);

        // 지도에 표시되고 있는 마커를 제거합니다
        removeMarker();

        for (var i = 0; i < places.length; i++) {

            // 마커를 생성하고 지도에 표시합니다
            var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
                marker = addMarker(placePosition, i),
                itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

            // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
            // LatLngBounds 객체에 좌표를 추가합니다
            bounds.extend(placePosition);

            // 마커와 검색결과 항목에 mouseover 했을때
            // 해당 장소에 인포윈도우에 장소명을 표시합니다
            // mouseout 했을 때는 인포윈도우를 닫습니다
            (function (marker, title) {
                kakao.maps.event.addListener(marker, 'mouseover', function () {
                    displayInfowindow(marker, title);
                });

                kakao.maps.event.addListener(marker, 'mouseout', function () {
                    infowindow.close();
                });

                itemEl.onmouseover = function () {
                    displayInfowindow(marker, title);
                };

                itemEl.onmouseout = function () {
                    infowindow.close();
                };
            })(marker, places[i].place_name);

            fragment.appendChild(itemEl);
        }

        // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
        listEl.appendChild(fragment);
        menuEl.scrollTop = 0;

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
        map.setBounds(bounds);
    }

    // 검색결과 항목을 Element로 반환하는 함수입니다
    function getListItem(index, places) {

        var el = document.createElement('li'),
            itemStr = '<span class="markerbg marker_' + (index + 1) + '"></span>' +
                '<div class="info">' +
                '   <h5>' + places.place_name + '</h5>';

        if (places.road_address_name) {
            itemStr += '    <span>' + places.road_address_name + '</span>' +
                '   <span class="jibun gray">' + places.address_name + '</span>';
        } else {
            itemStr += '    <span>' + places.address_name + '</span>';
        }

        itemStr += '  <span class="tel">' + places.phone + '</span>' +
            '</div>';

        el.innerHTML = itemStr;
        el.className = 'item';

        return el;
    }

    // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
    function addMarker(position, idx, title) {
        var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
            imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
            imgOptions = {
                spriteSize: new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
                spriteOrigin: new kakao.maps.Point(0, (idx * 46) + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
                offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
            },
            markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new kakao.maps.Marker({
                position: position, // 마커의 위치
                image: markerImage
            });

        marker.setMap(map); // 지도 위에 마커를 표출합니다
        markers.push(marker);  // 배열에 생성된 마커를 추가합니다

        return marker;
    }

    // 지도 위에 표시되고 있는 마커를 모두 제거합니다
    function removeMarker() {
        for (var i = 0; i < markers.length; i++) {
            markers[i].setMap(null);
        }
        markers = [];
    }

    // 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
    function displayPagination(pagination) {
        var paginationEl = document.getElementById('pagination'),
            fragment = document.createDocumentFragment(),
            i;

        // 기존에 추가된 페이지번호를 삭제합니다
        while (paginationEl.hasChildNodes()) {
            paginationEl.removeChild(paginationEl.lastChild);
        }

        for (i = 1; i <= pagination.last; i++) {
            var el = document.createElement('a');
            el.href = "#";
            el.innerHTML = i;

            if (i === pagination.current) {
                el.className = 'on';
            } else {
                el.onclick = (function (i) {
                    return function () {
                        pagination.gotoPage(i);
                    }
                })(i);
            }

            fragment.appendChild(el);
        }
        paginationEl.appendChild(fragment);
    }

    // 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
    // 인포윈도우에 장소명을 표시합니다
    function displayInfowindow(marker, title) {
        var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

        infowindow.setContent(content);
        infowindow.open(map, marker);
    }

    // 검색결과 목록의 자식 Element를 제거하는 함수입니다
    function removeAllChildNods(el) {
        while (el.hasChildNodes()) {
            el.removeChild(el.lastChild);
        }
    }
</script>


         <!--------------------->

         <div class="x4">
            <img class="image" src="file---1@1x.png">
         </div>
         <div class="overlap-group3">
            <div class="x143620">
               <div class="x4829"></div>
               <div class="overlap-group">
                  <img class="x4691" src="file---4691-1@1x.png">
                  <div class="fleet imhyemin-bold-black-31px" onclick="location.href='Main.jsp'">오점: 오늘의 점심</div>
                  <div class="copyright-2021-ui8 imhyemin-regular-normal-black-18px">
                     Copyright © 2022 인생모읍따.<br>&nbsp;&nbsp;All rights reserved
                  </div>
               </div>
            </div>
            
            <div class="overlap-group1-1">
               <div class="label-6 onemobilepop-regular-normal-white-20px">리뷰
                  쓰기</div>
            </div>
         </div>
      </div>
   </div>
