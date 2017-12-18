<?php
header('Content-Type:text/html;Charset=UTF-8');
error_reporting(E_ALL & ~E_NOTICE);
$swf='demo.swf';
?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title><?php echo $title; ?></title>
    <style type="text/css">
        body, html {
            height: 100%;
        }

        body {
            margin: 0;
            padding: 0;
            overflow: auto;
        }

        #flashContent {
            display: none;
        }
    </style>
</head>

<body>
<script type="text/javascript" src="js/swfobject/swfobject.js"></script>
<script type="text/javascript" src="js/flexpaper_flash_debug.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">
    var swfVersionStr = "10.0.0";
    var xiSwfUrlStr = "playerProductInstall.swf";
    var swfFile = '<?php echo $swf; ?>';
    var flashvars = {
        SwfFile: escape(swfFile),
        Scale: 0.6,
        StartAtPage: 1,
        ZoomTransition: "easeOut",
        ZoomTime: 0.5,
        ZoomInterval: 0.2,
        FitPageOnLoad: true,
        FitWidthOnLoad: true,
        PrintEnabled: true,
        FullScreenAsMaxWindow: true,
        ProgressiveLoading: true,
        localeChain: "zh_CN"
    };

    var params = {};
    params.quality = "high";
    params.bgcolor = "#ffffff";
    params.allowscriptaccess = "sameDomain";
    params.allowfullscreen = "true";
    var attributes = {};
    attributes.id = "FlexPaperViewer";
    attributes.name = "FlexPaperViewer";
    swfobject.embedSWF(
        "FlexPaperViewer.swf", "flashContent",
        "100%", "100%",
        swfVersionStr, xiSwfUrlStr,
        flashvars, params, attributes);
    swfobject.createCSS("#flashContent", "display:block;text-align:left;");
</script>

<div id="flashContent">
    <p>To view this page ensure that Adobe Flash Player version 10.0.0 or greater is installed. </p>
    <script type="text/javascript">
        var pageHost = ((document.location.protocol == "https:") ? "https://" : "http://");
        document.write("<a href='http://www.adobe.com/go/getflashplayer'><img src='" + pageHost + "www.adobe.com/images/shared/download_buttons/get_flash_player.gif' alt='Get Adobe Flash player' /></a>");
    </script>
</div>
</body>
</html>