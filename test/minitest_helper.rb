$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'stamper'

require 'minitest/autorun'

require 'debugger'

def rfc822_header_sample
  return <<-EOF.gsub(/^ {4}/, '')
    Return-Path:
      <signup-mc.us1_449017.612785-webmail.testing.dev=gmail.com@mail259.us2.mcsv.net>
    Delivered-To: webmail.testing.dev@gmail.com
    Received: by 10.114.57.180 with SMTP id j20csp135041ldq;
            Mon, 8 Oct 2012 05:57:59 -0700 (PDT)
    Received: by 10.60.171.80 with SMTP id as16mr6722098oec.49.1349701078731;
            Mon, 08 Oct 2012 05:57:58 -0700 (PDT)
    Received: from mail259.us2.mcsv.net (mail259.us2.mcsv.net. [173.231.138.196])
            by mx.google.com with ESMTP id lg5si19054451obb.164.2012.10.08.05.57.58;
            Mon, 08 Oct 2012 05:57:58 -0700 (PDT)
    Received-SPF: pass (google.com: domain of signup-mc.us1_449017.612785-webmail.testing.dev=gmail.com@mail259.us2.mcsv.net designates 173.231.138.196 as permitted sender) client-ip=173.231.138.196;
    Authentication-Results: mx.google.com; spf=pass (google.com: domain of signup-mc.us1_449017.612785-webmail.testing.dev=gmail.com@mail259.us2.mcsv.net designates 173.231.138.196 as permitted sender) smtp.mail=signup-mc.us1_449017.612785-webmail.testing.dev=gmail.com@mail259.us2.mcsv.net
    Received: by mail259.us2.mcsv.net (PowerMTA(TM) v3.5r16) id heb6tc0ik18c for <webmail.testing.dev@gmail.com>; Mon, 8 Oct 2012 12:57:57 +0000 (envelope-from <signup-mc.us1_449017.612785-webmail.testing.dev=gmail.com@mail259.us2.mcsv.net>)
    Sender: =?utf-8?Q?Ruby=20Weekly?= <rw@peterc.org>
    From: =?utf-8?Q?Ruby=20Weekly?= <rw@peterc.org>
    To: webmail.testing.dev@gmail.com
    Subject: Ruby Weekly: Subscription Confirmed
    Date: Mon, 08 Oct 2012 12:57:57 +0000
    Content-Type: multipart/mixed;
     boundary="=_3257aa0d778d005625c7d45aada96d41"
    MIME-Version: 1.0
    Message-ID: <0.5.2.438.1CDA5548A0C708A.0@mail259.us2.mcsv.net>

  EOF
end

def rfc822_sample
  body = <<-EOF.gsub(/^ {4}/, '')
    This is a message in Mime Format.  If you see this, your mail reader does not support this format.

    --=_3257aa0d778d005625c7d45aada96d41
    Content-Type: multipart/alternative;
     boundary="=_f5b8b3c81dd9ebb72d5d0b4891000eff"
    Content-Transfer-Encoding: 8bit


    --=_f5b8b3c81dd9ebb72d5d0b4891000eff
    Content-Type: text/plain; charset=utf-8
    Content-Transfer-Encoding: 7bit

    Your subscription to our list has been confirmed.

    For your records, here is a copy of the information you submitted to us...

     
    Email Address:  webmail.testing.dev@gmail.com
                  

    If at any time you wish to stop receiving our emails, you can:
    unsubscribe here (http://rubyweekly.us1.list-manage.com/unsubscribe?u=0618f6a79d6bb9675f313ceb2&id=d9d24eba5b&e=b4af456f64)
    You may also contact us at:
    peter@peterc.org (mailto:peter@peterc.org)


    --=_f5b8b3c81dd9ebb72d5d0b4891000eff
    Content-Type: text/html; charset=utf-8
    Content-Transfer-Encoding: quoted-printable

    <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://w=
    ww.w3.org/TR/html4/loose.dtd">=0A<html>=0A<head>=0A    <title>Ruby Weekl=
    y</title>=0A    <meta http-equiv=3D"Content-Type" content=3D"text/html;=
     charset=3Dutf-8">=0A    <meta name=3D"description" content=3D"Ruby Week=
    ly Email Forms">=0A    <meta name=3D"keywords" content=3D"Ruby Weekly">=
    =0A    <!-- Change the width below to just wider than your form's width=
    =0A    to optimize its initial scale on Apple iOS  and Android devices -=
    ->=0A    <meta name=3D"viewport" content=3D"width=3D640">=0A    =0A=0A=
    =0A=0A    =0A=0A</head>=0A<body style=3D"background-color: #FFFFFF;paddi=
    ng: 0px;margin: 0px;-webkit-text-size-adjust: none;">=0A    <table width=
    =3D"100%" cellpadding=3D"20" cellspacing=3D"0"><tr><td align=3D"center"=
     valign=3D"top">=0A    =0A    <!-- \\\ wrap table /// -->=0A=0A    <!---=
     /// ***************************************************** SIGNUP FORM P=
    AGE \\\ -->=0A    <table width=3D"600" cellpadding=3D"0" cellspacing=3D"=
    0" class=3D"container" style=3D"border: 1px solid #000000;">=0A    <tr>=
    =0A    <td align=3D"center" valign=3D"top">=0A    <div class=3D"headerBa=
    r" style=3D"background-color: #ffffff;padding: 20px;border-bottom: 0px s=
    olid #000000;">=0A        <div class=3D"headerText" style=3D"color: #fff=
    fff;font-size: 32px;font-family: Arial;font-weight: bold;text-align: lef=
    t;">=0A            <div style=3D"text-align: left;"><img src=3D"http://r=
    ubyweekly.com/logo2.gif" alt=3D"" border=3D"0" style=3D"height: 58px; wi=
    dth: 365px; margin: 0; padding: 0;" width=3D"365" height=3D"58"></div>=
    =0A        </div>=0A    </div>=0A    </td>=0A    </tr>=0A    <tr>=0A   =
     <td valign=3D"top" align=3D"left" class=3D"content formText" style=3D"b=
    ackground-color: #FFFFFF;padding: 20px;font-family: Arial;font-size: 12p=
    x;line-height: 150%;color: #333333;vertical-align: top;"><div id=3D"cont=
    ent">=0A        <div id=3D"welcomeEmail" class=3D"contentBox">=0A=0A<div=
     id=3D"welcomeEmailTop"><p style=3D"line-height: 150%;font-family: Arial=
    ;font-size: 12px;color: #333333;">Your subscription to our list has been=
     confirmed.</p>=0A</div>=0A<p style=3D"line-height: 150%;font-family: Ar=
    ial;font-size: 12px;color: #333333;">For your records, here is a copy of=
     the information you submitted to us...</p>=0A<blockquote>=0A<table>=0A=
    =0A=0A<tr><td class=3D"formText" style=3D"line-height: 150%;font-family:=
     Arial;font-size: 12px;color: #333333;vertical-align: top;">Email Addres=
    s:</td><td class=3D"formText" style=3D"line-height: 150%;font-family: Ar=
    ial;font-size: 12px;color: #333333;vertical-align: top;">webmail.testing=
    .dev@gmail.com</td></tr>=0A=0A=0A=0A=0A=0A=0A=0A=0A=0A=0A=0A=0A=0A=0A=0A=
    </table>=0A</blockquote>=0A<div id=3D"welcomeEmailBottom">=0A<p style=3D=
    "line-height: 150%;font-family: Arial;font-size: 12px;color: #333333;">I=
    f at any time you wish to stop receiving our emails, you can:<br>=0A   =
     <a class=3D"button" href=3D"http://rubyweekly.us1.list-manage.com/unsub=
    scribe?u=3D0618f6a79d6bb9675f313ceb2&id=3Dd9d24eba5b&e=3Db4af456f64" sty=
    le=3D"color: #ffffff;display: inline-block;font-family: 'Helvetica', Ari=
    al, sans-serif;width: auto;white-space: nowrap;height: 32px;margin: 5px=
     5px 0 0;padding: 0 22px;text-decoration: none;text-align: center;font-w=
    eight: bold;font-style: normal;font-size: 15px;line-height: 32px;cursor:=
     pointer;border: 0;-moz-border-radius: 4px;border-radius: 4px;-webkit-bo=
    rder-radius: 4px;vertical-align: top;background-color: #888888;"><span s=
    tyle=3D"display: inline;font-family: 'Helvetica', Arial, sans-serif;text=
    -decoration: none;text-align: center;font-weight: bold;font-style: norma=
    l;font-size: 15px;line-height: 32px;cursor: pointer;border: none;backgro=
    und-color: #888888;color: #ffffff;">unsubscribe here</span></a></p>=0A=
    =0A<p style=3D"line-height: 150%;font-family: Arial;font-size: 12px;colo=
    r: #333333;">You may also contact us at:=0A<br><a href=3D"mailto:peter@p=
    eterc.org" style=3D"color: #0000FF;">peter@peterc.org</a></p></div>=0A=
    =0A</div>=0A=0A    </div>=0A=0A    <br clear=3D"all">=0A=0A    =0A    </=
    td>=0A    </tr>=0A    </table>=0A    <!--- \\\ *************************=
    **************************** SIGNUP FORM PAGE /// -->=0A=0A    <!-- ///=
     wrap table \\\ -->=0A    </td></tr></table>=0A</body>=0A</html>=0A

    --=_f5b8b3c81dd9ebb72d5d0b4891000eff--

    --=_3257aa0d778d005625c7d45aada96d41
    Content-Type: text/x-vcard; profile="vcard"; charset="utf-8"
    Content-Transfer-Encoding: base64
    Content-Disposition: attachment; filename="Ruby_Weekly.vcf"

    QkVHSU46VkNBUkQKVkVSU0lPTjozLjAKRk46UnVieSBXZWVrbHkKTjpSdWJ5IFdlZWtseTs7
    OzsKUFJPRklMRTpWQ0FSRApBRFI6OzsxOTcgTmV3bWFya2V0O0xvdXRoO0xpbmNvbG5zaGly
    ZTtMTjExIDlFSjtVbml0ZWQgS2luZ2RvbQpFTUFJTDtUWVBFPVdPUks6cndAcGV0ZXJjLm9y
    ZwpPUkc6Q29kZXIgSU8KVVJMOmh0dHA6Ly9ydWJ5d2Vla2x5LmNvbS8KRU5EOlZDQVJECg==
    --=_3257aa0d778d005625c7d45aada96d41--
  EOF
  rfc822 = rfc822_header_sample + body
  return rfc822
end
