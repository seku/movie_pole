document.write('<!-- Template Id = 9417 Template Name = !IMDb 3rd Party Ad -->\n<!-- aid : 211553090 : 3RD-PARTY -->\n');

document.ad = { w: '300', h: '250', aid: '211553090', cid: '30106871' };

document.write('\n<!-- BEGIN 3RD-PARTY AD CONTENT -->\n\n');

document.ad = { w: '300', h: '250', aid: '211553090', cid: '30106871' };

document.write('\n\n<!-- BEGIN 3RD-PARTY AD CONTENT -->\n');

function google_ad_request_done(google_ads) {
    var s = '';
    var i;

    if (google_ads.length == 0)
        return;

    s += '<div style="font-size:10pt;border:1px solid black;padding:10px;font-family:Arial,Helvetica,sans-serif;">';
    s += '<div style="text-align:left;font-weight:bold;font-size:10pt;color:#B7B7B7;">Sponsored links</div>';


    for(i=0; i < google_ads.length; ++i) {
        s += '<div style="height:5px"></div><a href="' + google_ads[i].url +
             '" ' + 'target="_top" ' +
             'onmouseout="window.status=\'\'" ' +
             'onmouseover="window.status=\'go to ' +
             google_ads[i].visible_url + '\';return true;" ' +
             'style="text-decoration:none">' +
             '<span style="text-decoration:underline">' +
             '<b>' + google_ads[i].line1 + '</b><br></span>' +
             '<span style="color:#000000">' +
             google_ads[i].line2 + '<br>' +
             google_ads[i].line3 + '<br></span>' +
             '<span style="color:#008000">' +
             google_ads[i].visible_url + '</span></a><br>';
    }

    s += '</div>'
    document.write(s);
    return;
}

google_ad_client = 'ca-amazon-imdb-test_js';
google_ad_channel = 'intl1-channel';
google_ad_output = 'js';
google_max_num_ads = '3';
google_ad_type = 'text';
google_language = 'en';
google_image_size = '300x250';
google_encoding = 'utf8';
google_safe = 'high';
google_adtest = 'off';
google_ad_section = 'default';
// -->

document.write('\n\n<script type=\"text/javascript\"\nsrc=\"http://pagead2.googlesyndication.com/pagead/show_ads.js\">\n<\/script>');document.write('\n\n\n<!-- END 3RD-PARTY AD CONTENT -->');
