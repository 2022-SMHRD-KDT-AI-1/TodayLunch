<html><head>
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
<title>?????? ????????? ??????! ?????? ???????</title>




<meta charset="UTF-8">
<meta name="viewport" content="width=1366, maximum-scale=1.0">
<link rel="shortcut icon" type="image/x-icon" href="./oh_favicon.ico">
<meta name="og:type" content="website">
<meta name="twitter:card" content="photo">
<link rel="stylesheet" type="text/css" href="map.css">
<link rel="stylesheet" type="text/css" href="styleguide.css">
<link rel="stylesheet" type="text/css" href="globals.css">

<style>
.map_wrap, .map_wrap * {
	margin: 0;
	padding: 0;
	font-family: 'Malgun Gothic', dotum, '??????', sans-serif;
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



<script src="chrome-extension://mooikfkahbdckldjjndioackbalphokd/assets/prompt.js"></script>



<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7f9afc13f88bb23b506a837d3e1517d9&amp;libraries=services"></script><script charset="UTF-8" src="http://t1.daumcdn.net/mapjsapi/js/main/4.4.3/kakao.js"></script><script charset="UTF-8" src="http://t1.daumcdn.net/mapjsapi/js/libs/services/1.0.2/services.js"></script>
<script charset="UTF-8" src="http://t1.daumcdn.net/mapjsapi/js/main/4.4.3/kakao.js"></script>
<script charset="UTF-8" src="http://t1.daumcdn.net/mapjsapi/js/libs/services/1.0.2/services.js"></script>

<style>
@font-face {
    font-family: 'ONE-Mobile-POP';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2105_2@1.0/ONE-Mobile-POP.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}        
        </style>

</head>








<body style="margin: 0; background: #ffffff" data-new-gr-c-s-check-loaded="14.1047.0" data-gr-ext-installed="">
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
<p style="font-family:'ONE-Mobile-POP';" onclick="location.href='Main.jsp';">?????? : ????????? ??????</p>
										<div class="label-2" style="font-family: 'ONE-Mobile-POP';">????????? ??????</div>
									</div>
									<div class="label" style="font-family: 'ONE-Mobile-POP';">????????? ?????????</div>
									<div class="label-3" style="font-family: 'ONE-Mobile-POP';" onclick="location.href='Choice1.jsp';">?????? ?????? ?????????</div>
									<div class="label" style="font-family: 'ONE-Mobile-POP';">?????? ?????? ??????</div>
									<div class="label-4" style="font-family: 'ONE-Mobile-POP';">?????????</div>
									<div class="label-5" style="font-family: 'ONE-Mobile-POP';">????????????</div>
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
						<div id="map" style="width: 100%; height: 100%; position: relative; overflow: hidden; background: url(&quot;http://t1.daumcdn.net/mapjsapi/images/bg_tile.png&quot;);">
							<div style="position: absolute; left: 0px; top: 0px; width: 100%; height: 100%; touch-action: none; cursor: url(&quot;http://t1.daumcdn.net/mapjsapi/images/cursor/openhand.cur.ico&quot;) 7 5, url(&quot;http://t1.daumcdn.net/mapjsapi/images/cursor/openhand.cur.ico&quot;), default;">
								<div style="position: absolute; left: 489px; top: -145px;">
									<div style="position: absolute; z-index: 0; left: 0px; top: 0px;"></div>
									<div style="position: absolute; z-index: 1; left: 0px; top: 0px;">
										<img src="http://map2.daumcdn.net/map_2d/2111ydg/L13/0/-2.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -729px; top: 547px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://map3.daumcdn.net/map_2d/2111ydg/L13/0/-1.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -473px; top: 547px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://map0.daumcdn.net/map_2d/2111ydg/L13/0/0.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -217px; top: 547px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://map2.daumcdn.net/map_2d/2111ydg/L13/1/-2.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -729px; top: 291px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://map3.daumcdn.net/map_2d/2111ydg/L13/1/-1.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -473px; top: 291px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://map0.daumcdn.net/map_2d/2111ydg/L13/1/0.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -217px; top: 291px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://map2.daumcdn.net/map_2d/2111ydg/L13/2/-2.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -729px; top: 35px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://map3.daumcdn.net/map_2d/2111ydg/L13/2/-1.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -473px; top: 35px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://map0.daumcdn.net/map_2d/2111ydg/L13/2/0.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -217px; top: 35px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://map1.daumcdn.net/map_2d/2111ydg/L13/0/1.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 39px; top: 547px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://map1.daumcdn.net/map_2d/2111ydg/L13/1/1.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 39px; top: 291px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://map1.daumcdn.net/map_2d/2111ydg/L13/2/1.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 39px; top: 35px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://map2.daumcdn.net/map_2d/2111ydg/L13/0/2.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 295px; top: 547px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://map3.daumcdn.net/map_2d/2111ydg/L13/0/3.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 551px; top: 547px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://map0.daumcdn.net/map_2d/2111ydg/L13/0/4.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 807px; top: 547px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://s1.daumcdn.net/dmaps/apis/white.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 1063px; top: 547px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://s1.daumcdn.net/dmaps/apis/white.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 1319px; top: 547px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://map2.daumcdn.net/map_2d/2111ydg/L13/1/2.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 295px; top: 291px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://map3.daumcdn.net/map_2d/2111ydg/L13/1/3.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 551px; top: 291px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://map0.daumcdn.net/map_2d/2111ydg/L13/1/4.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 807px; top: 291px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://s1.daumcdn.net/dmaps/apis/white.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 1063px; top: 291px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://s1.daumcdn.net/dmaps/apis/white.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 1319px; top: 291px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://map2.daumcdn.net/map_2d/2111ydg/L13/2/2.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 295px; top: 35px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://map3.daumcdn.net/map_2d/2111ydg/L13/2/3.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 551px; top: 35px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://map0.daumcdn.net/map_2d/2111ydg/L13/2/4.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 807px; top: 35px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://s1.daumcdn.net/dmaps/apis/white.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 1063px; top: 35px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://s1.daumcdn.net/dmaps/apis/white.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 1319px; top: 35px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;">
									</div>
									<div style="position: absolute; z-index: 1;"></div>
									<div style="position: absolute; z-index: 1; width: 1024px; height: 500px;"></div>
									<div style="position: absolute; z-index: 1;">
										<svg version="1.1" style="stroke: none; stroke-dashoffset: 0.5; stroke-linejoin: round; fill: none; transform: translateZ(0px); position: absolute; left: -2537px; top: -855px; width: 5120px; height: 2500px;" viewBox="0 0 5120 2500">
                            <defs></defs>
                        </svg>
									</div>
									<div style="position: absolute; z-index: 1; width: 100%; height: 0px; transform: translateZ(0px);">
										<div style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: 5px; top: 303px; display: block;">
											<img draggable="false" src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png" alt="" title="" style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(10px, 36px, 47px, 0px); top: -10px; left: 0px; width: 36px; height: 691px;">
										</div>
										<div style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: 1px; top: 305px; display: block;">
											<img draggable="false" src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png" alt="" title="" style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(56px, 36px, 93px, 0px); top: -56px; left: 0px; width: 36px; height: 691px;">
										</div>
										<div style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: 10px; top: 311px; display: block;">
											<img draggable="false" src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png" alt="" title="" style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(102px, 36px, 139px, 0px); top: -102px; left: 0px; width: 36px; height: 691px;">
										</div>
										<div style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: 6px; top: 304px; display: block;">
											<img draggable="false" src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png" alt="" title="" style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(148px, 36px, 185px, 0px); top: -148px; left: 0px; width: 36px; height: 691px;">
										</div>
										<div style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: 0px; top: 305px; display: block;">
											<img draggable="false" src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png" alt="" title="" style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(194px, 36px, 231px, 0px); top: -194px; left: 0px; width: 36px; height: 691px;">
										</div>
										<div style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: 13px; top: 307px; display: block;">
											<img draggable="false" src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png" alt="" title="" style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(240px, 36px, 277px, 0px); top: -240px; left: 0px; width: 36px; height: 691px;">
										</div>
										<div style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: 12px; top: 308px; display: block;">
											<img draggable="false" src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png" alt="" title="" style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(286px, 36px, 323px, 0px); top: -286px; left: 0px; width: 36px; height: 691px;">
										</div>
										<div style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: 8px; top: 312px; display: block;">
											<img draggable="false" src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png" alt="" title="" style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(332px, 36px, 369px, 0px); top: -332px; left: 0px; width: 36px; height: 691px;">
										</div>
										<div style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: 0px; top: 305px; display: block;">
											<img draggable="false" src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png" alt="" title="" style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(378px, 36px, 415px, 0px); top: -378px; left: 0px; width: 36px; height: 691px;">
										</div>
										<div style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: -22px; top: 324px; display: block;">
											<img draggable="false" src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png" alt="" title="" style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(424px, 36px, 461px, 0px); top: -424px; left: 0px; width: 36px; height: 691px;">
										</div>
										<div style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: 1px; top: 305px; display: block;">
											<img draggable="false" src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png" alt="" title="" style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(470px, 36px, 507px, 0px); top: -470px; left: 0px; width: 36px; height: 691px;">
										</div>
										<div style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: 47px; top: 405px; display: block;">
											<img draggable="false" src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png" alt="" title="" style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(516px, 36px, 553px, 0px); top: -516px; left: 0px; width: 36px; height: 691px;">
										</div>
										<div style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: 148px; top: 487px; display: block;">
											<img draggable="false" src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png" alt="" title="" style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(562px, 36px, 599px, 0px); top: -562px; left: 0px; width: 36px; height: 691px;">
										</div>
										<div style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: 194px; top: 565px; display: block;">
											<img draggable="false" src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png" alt="" title="" style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(608px, 36px, 645px, 0px); top: -608px; left: 0px; width: 36px; height: 691px;">
										</div>
										<div style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: 0px; top: 298px; display: block;">
											<img draggable="false" src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png" alt="" title="" style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(654px, 36px, 691px, 0px); top: -654px; left: 0px; width: 36px; height: 691px;">
										</div>
									</div>
								</div>
							</div>
							<div style="position: absolute; cursor: default; z-index: 1; margin: 0px 6px; height: 19px; line-height: 14px; left: 0px; bottom: 0px; color: rgb(0, 0, 0);">
								<div style="color: rgb(0, 0, 0); text-align: center; font-size: 10px; float: left;">
									<div style="float: left; margin: 2px 3px 0px 4px; height: 6px; transition: width 0.1s ease 0s; border-top: none rgb(0, 0, 0); border-right: 2px solid rgb(0, 0, 0); border-bottom: 2px solid rgb(0, 0, 0); border-left: 2px solid rgb(0, 0, 0); border-image: initial; width: 58px;">
									</div>
									<div style="float: left; margin: 0px 4px 0px 0px; font-family: AppleSDGothicNeo-Regular, ??????, dotum, sans-serif; font-weight: bold; color: rgb(0, 0, 0);">
										64km</div>
								</div>
								<div style="margin: 0px 4px; float: left;">
									<a target="_blank" href="http://map.kakao.com/" title="Kakao ????????? ???????????? ???????????????." style="float: left; width: 32px; height: 10px;"><img src="http://t1.daumcdn.net/mapjsapi/images/m_bi_b.png" alt="Kakao ????????? ??????" style="float: left; width: 32px; height: 10px; border: none;"></a>
									<div style="font: 11px/11px Arial, Tahoma, Dotum, sans-serif; float: left;"></div>
								</div>
							</div>
							<div style="cursor: auto; position: absolute; z-index: 2; left: 0px; top: 0px;"></div>
						<div style="position: absolute; left: 0px; top: 0px; width: 100%; height: 100%; touch-action: none; cursor: url(&quot;http://t1.daumcdn.net/mapjsapi/images/cursor/openhand.cur.ico&quot;) 7 5, url(&quot;http://t1.daumcdn.net/mapjsapi/images/cursor/openhand.cur.ico&quot;), default;"><div style="position: absolute; left: 536px; top: -404px;"><div style="position: absolute; z-index: 1; left: 0px; top: 0px;"><img src="http://map3.daumcdn.net/map_2d/2111ydg/L4/473/435.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -679px; top: 980px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://map0.daumcdn.net/map_2d/2111ydg/L4/473/436.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -423px; top: 980px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://map1.daumcdn.net/map_2d/2111ydg/L4/473/437.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -167px; top: 980px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://map2.daumcdn.net/map_2d/2111ydg/L4/473/438.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 89px; top: 980px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://map3.daumcdn.net/map_2d/2111ydg/L4/473/439.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 345px; top: 980px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://map0.daumcdn.net/map_2d/2111ydg/L4/473/440.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 601px; top: 980px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://map3.daumcdn.net/map_2d/2111ydg/L4/474/435.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -679px; top: 724px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://map0.daumcdn.net/map_2d/2111ydg/L4/474/436.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -423px; top: 724px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://map1.daumcdn.net/map_2d/2111ydg/L4/474/437.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -167px; top: 724px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://map2.daumcdn.net/map_2d/2111ydg/L4/474/438.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 89px; top: 724px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://map3.daumcdn.net/map_2d/2111ydg/L4/474/439.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 345px; top: 724px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://map0.daumcdn.net/map_2d/2111ydg/L4/474/440.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 601px; top: 724px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://map3.daumcdn.net/map_2d/2111ydg/L4/475/435.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -679px; top: 468px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://map0.daumcdn.net/map_2d/2111ydg/L4/475/436.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -423px; top: 468px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://map1.daumcdn.net/map_2d/2111ydg/L4/475/437.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -167px; top: 468px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://map2.daumcdn.net/map_2d/2111ydg/L4/475/438.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 89px; top: 468px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://map3.daumcdn.net/map_2d/2111ydg/L4/475/439.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 345px; top: 468px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://map0.daumcdn.net/map_2d/2111ydg/L4/475/440.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 601px; top: 468px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://map3.daumcdn.net/map_2d/2111ydg/L4/476/435.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -679px; top: 212px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://map0.daumcdn.net/map_2d/2111ydg/L4/476/436.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -423px; top: 212px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://map1.daumcdn.net/map_2d/2111ydg/L4/476/437.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -167px; top: 212px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://map2.daumcdn.net/map_2d/2111ydg/L4/476/438.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 89px; top: 212px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://map3.daumcdn.net/map_2d/2111ydg/L4/476/439.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 345px; top: 212px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="http://map0.daumcdn.net/map_2d/2111ydg/L4/476/440.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 601px; top: 212px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"></div><div style="position: absolute; z-index: 0; left: 0px; top: 0px;"><img src="http://map3.daumcdn.net/map_2d/2111ydg/L5/236/215.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -1958px; top: 980px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 512px; height: 512px;"><img src="http://map0.daumcdn.net/map_2d/2111ydg/L5/236/216.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -1446px; top: 980px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 512px; height: 512px;"><img src="http://map1.daumcdn.net/map_2d/2111ydg/L5/236/217.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -934px; top: 980px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 512px; height: 512px;"><img src="http://map2.daumcdn.net/map_2d/2111ydg/L5/236/218.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -422px; top: 980px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 512px; height: 512px;"><img src="http://map3.daumcdn.net/map_2d/2111ydg/L5/236/219.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 90px; top: 980px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 512px; height: 512px;"><img src="http://map0.daumcdn.net/map_2d/2111ydg/L5/236/220.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 602px; top: 980px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 512px; height: 512px;"><img src="http://map3.daumcdn.net/map_2d/2111ydg/L5/237/215.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -1958px; top: 468px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 512px; height: 512px;"><img src="http://map0.daumcdn.net/map_2d/2111ydg/L5/237/216.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -1446px; top: 468px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 512px; height: 512px;"><img src="http://map1.daumcdn.net/map_2d/2111ydg/L5/237/217.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -934px; top: 468px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 512px; height: 512px;"><img src="http://map2.daumcdn.net/map_2d/2111ydg/L5/237/218.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -422px; top: 468px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 512px; height: 512px;"><img src="http://map3.daumcdn.net/map_2d/2111ydg/L5/237/219.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 90px; top: 468px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 512px; height: 512px;"><img src="http://map0.daumcdn.net/map_2d/2111ydg/L5/237/220.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 602px; top: 468px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 512px; height: 512px;"><img src="http://map3.daumcdn.net/map_2d/2111ydg/L5/238/215.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -1958px; top: -44px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 512px; height: 512px;"><img src="http://map0.daumcdn.net/map_2d/2111ydg/L5/238/216.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -1446px; top: -44px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 512px; height: 512px;"><img src="http://map1.daumcdn.net/map_2d/2111ydg/L5/238/217.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -934px; top: -44px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 512px; height: 512px;"><img src="http://map2.daumcdn.net/map_2d/2111ydg/L5/238/218.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -422px; top: -44px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 512px; height: 512px;"><img src="http://map3.daumcdn.net/map_2d/2111ydg/L5/238/219.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 90px; top: -44px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 512px; height: 512px;"><img src="http://map0.daumcdn.net/map_2d/2111ydg/L5/238/220.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 602px; top: -44px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 512px; height: 512px;"><img src="http://map3.daumcdn.net/map_2d/2111ydg/L5/235/215.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -1958px; top: 1492px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 512px; height: 512px;"><img src="http://map0.daumcdn.net/map_2d/2111ydg/L5/235/216.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -1446px; top: 1492px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 512px; height: 512px;"><img src="http://map1.daumcdn.net/map_2d/2111ydg/L5/235/217.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -934px; top: 1492px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 512px; height: 512px;"><img src="http://map2.daumcdn.net/map_2d/2111ydg/L5/235/218.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -422px; top: 1492px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 512px; height: 512px;"><img src="http://map3.daumcdn.net/map_2d/2111ydg/L5/235/219.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 90px; top: 1492px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 512px; height: 512px;"><img src="http://map0.daumcdn.net/map_2d/2111ydg/L5/235/220.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 602px; top: 1492px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 512px; height: 512px;"></div><div style="position: absolute; z-index: 1;"></div><div style="width: 1268px; height: 700px; position: absolute; z-index: 1;"></div><div style="position: absolute; z-index: 1;"><svg version="1.1" style="stroke: none; stroke-dashoffset: 0.5; stroke-linejoin: round; fill: none; transform: translateZ(0px); position: absolute; left: -3072px; top: -996px; width: 6340px; height: 3500px;" viewBox="0 0 6340 3500"><defs></defs></svg></div><div style="position: absolute; z-index: 1; width: 100%; height: 0px; transform: translateZ(0px);"><div style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: -513px; top: 483px; display: block;"><img draggable="false" src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png" alt="" title="" style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(10px, 36px, 47px, 0px); top: -10px; left: 0px; width: 36px; height: 691px;"></div><div style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: 175px; top: 1325px; display: none;"><img draggable="false" src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png" alt="" title="" style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(56px, 36px, 93px, 0px); top: -56px; left: 0px; width: 36px; height: 691px;"></div><div style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: -917px; top: 576px; display: none;"><img draggable="false" src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png" alt="" title="" style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(102px, 36px, 139px, 0px); top: -102px; left: 0px; width: 36px; height: 691px;"></div><div style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: -874px; top: 359px; display: none;"><img draggable="false" src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png" alt="" title="" style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(148px, 36px, 185px, 0px); top: -148px; left: 0px; width: 36px; height: 691px;"></div><div style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: -451px; top: 483px; display: block;"><img draggable="false" src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png" alt="" title="" style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(194px, 36px, 231px, 0px); top: -194px; left: 0px; width: 36px; height: 691px;"></div><div style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: -241px; top: 720px;"><img draggable="false" src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png" alt="" title="" style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(240px, 36px, 277px, 0px); top: -240px; left: 0px; width: 36px; height: 691px;"></div><div style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: -781px; top: 612px; display: none;"><img draggable="false" src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png" alt="" title="" style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(286px, 36px, 323px, 0px); top: -286px; left: 0px; width: 36px; height: 691px;"></div><div style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: -574px; top: 385px; display: none;"><img draggable="false" src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png" alt="" title="" style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(332px, 36px, 369px, 0px); top: -332px; left: 0px; width: 36px; height: 691px;"></div><div style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: -465px; top: 517px; display: block;"><img draggable="false" src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png" alt="" title="" style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(378px, 36px, 415px, 0px); top: -378px; left: 0px; width: 36px; height: 691px;"></div><div style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: -942px; top: 614px; display: none;"><img draggable="false" src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png" alt="" title="" style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(424px, 36px, 461px, 0px); top: -424px; left: 0px; width: 36px; height: 691px;"></div><div style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: -766px; top: 573px; display: none;"><img draggable="false" src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png" alt="" title="" style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(470px, 36px, 507px, 0px); top: -470px; left: 0px; width: 36px; height: 691px;"></div><div style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: -440px; top: 517px;"><img draggable="false" src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png" alt="" title="" style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(516px, 36px, 553px, 0px); top: -516px; left: 0px; width: 36px; height: 691px;"></div><div style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: -936px; top: 607px; display: none;"><img draggable="false" src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png" alt="" title="" style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(562px, 36px, 599px, 0px); top: -562px; left: 0px; width: 36px; height: 691px;"></div><div style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: -753px; top: 524px; display: none;"><img draggable="false" src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png" alt="" title="" style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(608px, 36px, 645px, 0px); top: -608px; left: 0px; width: 36px; height: 691px;"></div><div style="position: absolute; margin: -37px 0px 0px -13px; z-index: 0; left: -94px; top: 349px; display: none;"><img draggable="false" src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png" alt="" title="" style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(654px, 36px, 691px, 0px); top: -654px; left: 0px; width: 36px; height: 691px;"></div></div></div></div><div style="position: absolute; cursor: default; z-index: 1; margin: 0px 6px; height: 19px; line-height: 14px; left: 0px; bottom: 0px; color: rgb(0, 0, 0);"><div style="color: rgb(0, 0, 0); text-align: center; font-size: 10px; float: left;"><div style="float: left; margin: 2px 3px 0px 4px; height: 6px; transition: width 0.1s ease 0s; border-top: none rgb(0, 0, 0); border-right: 2px solid rgb(0, 0, 0); border-bottom: 2px solid rgb(0, 0, 0); border-left: 2px solid rgb(0, 0, 0); border-image: initial; width: 46px;"></div><div style="float: left; margin: 0px 4px 0px 0px; font-family: AppleSDGothicNeo-Regular, ??????, dotum, sans-serif; font-weight: bold; color: rgb(0, 0, 0);">100m</div></div><div style="margin: 0px 4px; float: left;"><a target="_blank" href="http://map.kakao.com/" title="Kakao ????????? ???????????? ???????????????." style="float: left; width: 32px; height: 10px;"><img src="http://t1.daumcdn.net/mapjsapi/images/m_bi_b.png" alt="Kakao ????????? ??????" style="float: left; width: 32px; height: 10px; border: none;"></a><div style="font: 11px / 11px Arial, Tahoma, Dotum, sans-serif; float: left;"></div></div></div><div style="cursor: auto; position: absolute; z-index: 2; left: 0px; top: 0px;"></div></div>

						<div id="menu_wrap" class="bg_white">
							<div class="option">
								<div>
									<form onsubmit="searchPlaces(); return false;">
										????????? : <input type="text" value="null" id="keyword" size="15">
										<button type="submit">????????????</button>
									</form>
								</div>
							</div>
							<hr>
							<ul id="placesList"><li class="item"><span class="markerbg marker_1"></span><div class="info">   <h5>?????????</h5>    <span>?????? ?????? ???????????? 132</span>   <span class="jibun gray">?????? ?????? ?????? 67-2</span>  <span class="tel">062-227-9085</span></div></li><li class="item"><span class="markerbg marker_2"></span><div class="info">   <h5>?????????</h5>    <span>?????? ?????? ???????????? 110</span>   <span class="jibun gray">?????? ?????? ?????? 262-12</span>  <span class="tel">062-234-5673</span></div></li><li class="item"><span class="markerbg marker_3"></span><div class="info">   <h5>??????</h5>    <span>?????? ?????? ?????????160?????? 15-9</span>   <span class="jibun gray">?????? ?????? ????????? 13-6</span>  <span class="tel">062-227-3250</span></div></li><li class="item"><span class="markerbg marker_4"></span><div class="info">   <h5>??????????????????</h5>    <span>?????? ?????? ?????????194?????? 21</span>   <span class="jibun gray">?????? ?????? ????????? 129-1</span>  <span class="tel">062-410-9015</span></div></li><li class="item"><span class="markerbg marker_5"></span><div class="info">   <h5>????????????</h5>    <span>?????? ?????? ???????????? 143-11</span>   <span class="jibun gray">?????? ?????? ????????? 75-31</span>  <span class="tel"></span></div></li><li class="item"><span class="markerbg marker_6"></span><div class="info">   <h5>???????????????</h5>    <span>?????? ?????? ????????????287?????? 23-10</span>   <span class="jibun gray">?????? ?????? ????????? 505-11</span>  <span class="tel">062-955-8557</span></div></li><li class="item"><span class="markerbg marker_7"></span><div class="info">   <h5>????????????0410 ??????????????????</h5>    <span>?????? ?????? ????????? 102-2</span>   <span class="jibun gray">?????? ?????? ?????????1??? 26-1</span>  <span class="tel">062-232-4989</span></div></li><li class="item"><span class="markerbg marker_8"></span><div class="info">   <h5>??????????????????</h5>    <span>?????? ?????? ?????????25?????? 9-9</span>   <span class="jibun gray">?????? ?????? ????????? 200-189</span>  <span class="tel"></span></div></li><li class="item"><span class="markerbg marker_9"></span><div class="info">   <h5>?????????????????? ?????????</h5>    <span>?????? ?????? ????????? 23-20</span>   <span class="jibun gray">?????? ?????? ?????? 79-4</span>  <span class="tel">062-222-1947</span></div></li><li class="item"><span class="markerbg marker_10"></span><div class="info">   <h5>???????????? ?????????</h5>    <span>?????? ?????? ?????????160?????? 16-8</span>   <span class="jibun gray">?????? ?????? ????????? 78-1</span>  <span class="tel">062-224-5957</span></div></li><li class="item"><span class="markerbg marker_11"></span><div class="info">   <h5>???????????????</h5>    <span>?????? ?????? ????????? 246</span>   <span class="jibun gray">?????? ?????? ?????????1??? 19-4</span>  <span class="tel">062-224-8745</span></div></li><li class="item"><span class="markerbg marker_12"></span><div class="info">   <h5>???????????? ?????????</h5>    <span>?????? ?????? ???????????? 147</span>   <span class="jibun gray">?????? ?????? ????????? 72-18</span>  <span class="tel">062-226-7799</span></div></li><li class="item"><span class="markerbg marker_13"></span><div class="info">   <h5>??????????????? ???????????????</h5>    <span>?????? ?????? ?????????160?????? 16-4</span>   <span class="jibun gray">?????? ?????? ????????? 78-5</span>  <span class="tel">062-225-7942</span></div></li><li class="item"><span class="markerbg marker_14"></span><div class="info">   <h5>????????????</h5>    <span>?????? ?????? ?????????196?????? 32</span>   <span class="jibun gray">?????? ?????? ?????????2??? 15</span>  <span class="tel">062-233-5525</span></div></li><li class="item"><span class="markerbg marker_15"></span><div class="info">   <h5>??????????????????</h5>    <span>?????? ?????? ????????????205?????? 18</span>   <span class="jibun gray">?????? ?????? ????????? 713-13</span>  <span class="tel">062-233-5789</span></div></li></ul>
							<div id="pagination"><a href="#" class="on">1</a><a href="#">2</a><a href="#">3</a></div>
						</div>
					</div>








				</div>
			</div>


			<script>
    // ????????? ?????? ???????????????
    var markers = [];

    var mapContainer = document.getElementById('map'), // ????????? ????????? div 
        mapOption = {
            center: new kakao.maps.LatLng(35.14983227454257, 126.91995574070474), // ????????? ????????????
            level: 1 // ????????? ?????? ??????
        };

    // ????????? ???????????????    
    var map = new kakao.maps.Map(mapContainer, mapOption);

    // ?????? ?????? ????????? ???????????????
    var ps = new kakao.maps.services.Places();

    // ?????? ?????? ???????????? ????????? ???????????? ??? ???????????? ????????? ?????????????????? ???????????????
    var infowindow = new kakao.maps.InfoWindow({ zIndex: 1 });

    // ???????????? ????????? ???????????????
    searchPlaces();

    // ????????? ????????? ???????????? ???????????????
    function searchPlaces() {

        var keyword = document.getElementById('keyword').value;

        if (!keyword.replace(/^\s+|\s+$/g, '')) {
            alert('???????????? ??????????????????!');
            return false;
        }
		//keyword = '%=??????????????????%>'+keyword //???????????? ?????????????????????????????????
		keyword = '?????? ??????'+keyword
        // ???????????? ????????? ?????? ???????????? ??????????????? ???????????????
        ps.keywordSearch(keyword, placesSearchCB);
    }

    // ??????????????? ???????????? ??? ???????????? ???????????? ?????????
    function placesSearchCB(data, status, pagination) {
        if (status === kakao.maps.services.Status.OK) {

            // ??????????????? ????????? ???????????????
            // ?????? ????????? ????????? ???????????????
            displayPlaces(data);

            // ????????? ????????? ???????????????
            displayPagination(pagination);

        } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

            alert('?????? ????????? ???????????? ????????????.');
            return;

        } else if (status === kakao.maps.services.Status.ERROR) {

            alert('?????? ?????? ??? ????????? ??????????????????.');
            return;

        }
    }

    // ?????? ?????? ????????? ????????? ???????????? ???????????????
    function displayPlaces(places) {

        var listEl = document.getElementById('placesList'),
            menuEl = document.getElementById('menu_wrap'),
            fragment = document.createDocumentFragment(),
            bounds = new kakao.maps.LatLngBounds(),
            listStr = '';

        // ?????? ?????? ????????? ????????? ???????????? ???????????????
        removeAllChildNods(listEl);

        // ????????? ???????????? ?????? ????????? ???????????????
        removeMarker();

        for (var i = 0; i < places.length; i++) {

            // ????????? ???????????? ????????? ???????????????
            var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
                marker = addMarker(placePosition, i),
                itemEl = getListItem(i, places[i]); // ?????? ?????? ?????? Element??? ???????????????

            // ????????? ?????? ????????? ???????????? ?????? ????????? ?????????????????????
            // LatLngBounds ????????? ????????? ???????????????
            bounds.extend(placePosition);

            // ????????? ???????????? ????????? mouseover ?????????
            // ?????? ????????? ?????????????????? ???????????? ???????????????
            // mouseout ?????? ?????? ?????????????????? ????????????
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

        // ???????????? ???????????? ???????????? ?????? Element??? ???????????????
        listEl.appendChild(fragment);
        menuEl.scrollTop = 0;

        // ????????? ?????? ????????? ???????????? ?????? ????????? ??????????????????
        map.setBounds(bounds);
    }

    // ???????????? ????????? Element??? ???????????? ???????????????
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

    // ????????? ???????????? ?????? ?????? ????????? ???????????? ???????????????
    function addMarker(position, idx, title) {
        var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // ?????? ????????? url, ??????????????? ???????????? ?????????
            imageSize = new kakao.maps.Size(36, 37),  // ?????? ???????????? ??????
            imgOptions = {
                spriteSize: new kakao.maps.Size(36, 691), // ??????????????? ???????????? ??????
                spriteOrigin: new kakao.maps.Point(0, (idx * 46) + 10), // ??????????????? ????????? ??? ????????? ????????? ????????? ??????
                offset: new kakao.maps.Point(13, 37) // ?????? ????????? ???????????? ????????? ???????????? ??????
            },
            markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new kakao.maps.Marker({
                position: position, // ????????? ??????
                image: markerImage
            });

        marker.setMap(map); // ?????? ?????? ????????? ???????????????
        markers.push(marker);  // ????????? ????????? ????????? ???????????????

        return marker;
    }

    // ?????? ?????? ???????????? ?????? ????????? ?????? ???????????????
    function removeMarker() {
        for (var i = 0; i < markers.length; i++) {
            markers[i].setMap(null);
        }
        markers = [];
    }

    // ???????????? ?????? ????????? ?????????????????? ????????? ???????????????
    function displayPagination(pagination) {
        var paginationEl = document.getElementById('pagination'),
            fragment = document.createDocumentFragment(),
            i;

        // ????????? ????????? ?????????????????? ???????????????
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

    // ???????????? ?????? ?????? ????????? ???????????? ??? ???????????? ???????????????
    // ?????????????????? ???????????? ???????????????
    function displayInfowindow(marker, title) {
        var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

        infowindow.setContent(content);
        infowindow.open(map, marker);
    }

    // ???????????? ????????? ?????? Element??? ???????????? ???????????????
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
						<div class="fleet imhyemin-bold-black-31px" onclick="location.href='Main.jsp'">??????: ????????? ??????</div>
						<div class="copyright-2021-ui8 imhyemin-regular-normal-black-18px">
							Copyright ?? 2022 ???????????????.<br>&nbsp;&nbsp;All rights reserved
						</div>
					</div>
				</div>
				
				<div class="overlap-group1-1">
					<div class="label-6 onemobilepop-regular-normal-white-20px">??????
						??????</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>
