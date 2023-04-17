public with sharing class JsonResponsesContainer {
	public static final String MESSAGE_ID_FOR_FILTERING = '18596c90603cb9bc';
	public static final String MESSAGE_ID = '18597e031b4f39c3';

	private static final String SENDER = 'Steven Altamirano \u003csteven.altamirano.sf@gmail.com\u003e';
	private static final String SUBJECT = 'Test';
	private static final String MESSAGE = 'Test!';

	public static final List<String> parsedMessageIds = new List<String>{
		'18597e031b4f39c3',
		'18596c90603cb9bc'
	};

	public static final String MESSAGE_IDS_RESPONSE =
		'{' +
		'"messages": [' +
		'    {' +
		'       "id": "18597e031b4f39c3",' +
		'       "threadId": "18597e031b4f39c3"' +
		'    },' +
		'   {' +
		'       "id": "18596c90603cb9bc",' +
		'       "threadId": "18596c90603cb9bc"' +
		'    }' +
		'],' +
		'"resultSizeEstimate": 2}';

	public static final String MESSAGE_RESPONSE =
		'{' +
		'  "id": "18597e031b4f39c3",' +
		'  "threadId": "18597e031b4f39c3",' +
		'  "labelIds": [' +
		'    "CATEGORY_PERSONAL",' +
		'    "INBOX"' +
		'  ],' +
		'  "snippet": "Test!",' +
		'  "payload": {' +
		'    "partId": "",' +
		'    "mimeType": "multipart/alternative",' +
		'    "filename": "",' +
		'    "headers": [' +
		'      {' +
		'        "name": "Delivered-To",' +
		'        "value": "test.public.api.sa@gmail.com"' +
		'      },' +
		'      {' +
		'        "name": "Received",' +
		'        "value": "by 2002:a05:6358:2607:b0:df:50ee:c59 with SMTP id l7csp6230921rwc;        Mon, 9 Jan 2023 10:52:10 -0800 (PST)"' +
		'      },' +
		'      {' +
		'        "name": "X-Received",' +
		'        "value": "by 2002:ac2:4bcb:0:b0:4bb:8d56:d859 with SMTP id o11-20020ac24bcb000000b004bb8d56d859mr19723548lfq.6.1673290330502;        Mon, 09 Jan 2023 10:52:10 -0800 (PST)"' +
		'      },' +
		'      {' +
		'        "name": "ARC-Seal",' +
		'        "value": "i=1; a=rsa-sha256; t=1673290330; cv=none;        d=google.com; s=arc-20160816;        b=lO48/mzXy5KQmPHlpYABlSnbOaKzAgCTWoxBQ3KrlkaeP5waeDXeV1NXW08f2JeJ7B         oBtV5W3xf60PKUr4Jz1vrh0b2cwKrtBWcFueR8TXTL2+JmCcxvjClU9mzA+ER4MEYIeJ         77oEvp708EerATgtxuTox9ofVnjQWSXfqD9z0+HmdhrxVN5lNRSRkQ0TzBHKWTqerldx         V868Vf9hVCBpkJEvC+jmMjnubQbY5i1B/hxJ9vuhdmgawWTbim+eeH9CcZ/iLh6OtmRV         bWSukESTjMcjMy8OEqCRZI4khcFANRQ1GkZJnrnVnXQUFjt1vfcdeLL7ml2DuRasb9Vh         +pUQ=="' +
		'      },' +
		'      {' +
		'        "name": "ARC-Message-Signature",' +
		'        "value": "i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;        h=to:subject:message-id:date:from:mime-version:dkim-signature;        bh=PRBLdiWmhlD2RgizU49xzKcEzyKZEBGAEgtxFdQsbog=;        b=KfUTiH2goCAXGafS1cVaiVzsRA0h8WPgxaLNcAkWrAeOTVBlJ8+AYAxk07Xx7YBDPV         rz7oLpAFjA3ak8u0Qhh0Gba9C61FFODYQaL+FFesbNcmwFZ4aN0M7voY209Kim5Tn3o5         HXkPT6JYh8qsZWZbSVIgsCb03hOj2so6vpM0qgyyO2WUgfWNal9uTpyyTndR9kqfPKYP         4ZUzuR51cSd/9bfmLlWWz5b61TSlqPbxOSO+Ys2s8NzcxHqii/rHVmCHXV01WzmglH6D         RDFHJOTPxeXprZZQnnpuFh4iiyELNgg012PGt5WTRLapaiuY5NO4DaLTA/U1oBx/anrL         W2hA=="' +
		'      },' +
		'      {' +
		'        "name": "ARC-Authentication-Results",' +
		'        "value": "i=1; mx.google.com;       dkim=pass header.i=@gmail.com header.s=20210112 header.b=eZNaPhjO;       spf=pass (google.com: domain of steven.altamirano.sf@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=steven.altamirano.sf@gmail.com;       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com"' +
		'      },' +
		'      {' +
		'        "name": "Return-Path",' +
		'        "value": "\\u003csteven.altamirano.sf@gmail.com\\u003e"' +
		'      },' +
		'      {' +
		'        "name": "Received",' +
		'        "value": "from mail-sor-f41.google.com (mail-sor-f41.google.com. [209.85.220.41])        by mx.google.com with SMTPS id s19-20020a195e13000000b004ab61bfc822sor1851751lfb.75.2023.01.09.10.52.10        for \\u003ctest.public.api.sa@gmail.com\\u003e        (Google Transport Security);        Mon, 09 Jan 2023 10:52:10 -0800 (PST)"' +
		'      },' +
		'      {' +
		'        "name": "Received-SPF",' +
		'        "value": "pass (google.com: domain of steven.altamirano.sf@gmail.com designates 209.85.220.41 as permitted sender) client-ip=209.85.220.41;"' +
		'      },' +
		'      {' +
		'        "name": "Authentication-Results",' +
		'        "value": "mx.google.com;       dkim=pass header.i=@gmail.com header.s=20210112 header.b=eZNaPhjO;       spf=pass (google.com: domain of steven.altamirano.sf@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=steven.altamirano.sf@gmail.com;       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com"' +
		'      },' +
		'      {' +
		'        "name": "DKIM-Signature",' +
		'        "value": "v=1; a=rsa-sha256; c=relaxed/relaxed;        d=gmail.com; s=20210112;        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject         :date:message-id:reply-to;        bh=PRBLdiWmhlD2RgizU49xzKcEzyKZEBGAEgtxFdQsbog=;        b=eZNaPhjOcA+4wdgC99J2kI+GEozSRkWv3tUtS1gJXKzDLsJqhKZdT/9WN6+CWWqozh         RPGVMC2P7HNZxT7TlPXO06BGl3cZ/uPRERCAnSDa2gc9GSASdN2tpXiSFNO5ia0ROPIa         hTG1RDrctnKBlm+1XP9EPZx6X9bFiZxXhUXbIl2QItgoH5A+zvDaeOci6MzrdPsWJWi2         rqHCvb69MaqaY/TxezBIsKpS7kkpmd3Art/QfUprHpyEQ/9DlSdsZtmuVG19gim7y9EY         0ynSXswRpO78RLdeWx4v64z4310PxvVcYgRQHCKU6SWx/UB5IkEeODoS9zBF86KZDpV7         oxFA=="' +
		'      },' +
		'      {' +
		'        "name": "X-Google-DKIM-Signature",' +
		'        "value": "v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20210112;        h=to:subject:message-id:date:from:mime-version:x-gm-message-state         :from:to:cc:subject:date:message-id:reply-to;        bh=PRBLdiWmhlD2RgizU49xzKcEzyKZEBGAEgtxFdQsbog=;        b=rHM5GeJbKRLzqtGSOpFzThrVreItaJGUb85y9ri5p0haJsGa8J1nOwntab85PJNy+O         swF/PqcMk/JlpZcGPCOLsmCf+uvxgb7uywQoAE6sBbCwAQjNUKy0bjkqf2vj62Di4on/         VksTEa7mw4P/ztHgeXDKHixD1zmx6CvZcUkvE4J+B4JziAW3jbJunO3aIpw9+vfgIJnf         0GzI0n3ax/iCN79VupnvNmz2CYkDJrLUfGntn0Ynu/grgnt3iQt+87E23fi4WMf/SStV         inJlmF+Lo9bo/dNW8UZQxeEKwN/xqAOH17cGtwFeVot8jDf1E5NiQLqBuBmgECOhwOWG         9l4g=="' +
		'      },' +
		'      {' +
		'        "name": "X-Gm-Message-State",' +
		'        "value": "AFqh2kqRAv/K2KGHiA1piI/sRyUt3pwrn2ZTuVIJyZmaNYA4IQCSafm1 pWmnfc8indS5HVisLTdnte4+XXsblTwUOc8cqXGdSgAc"' +
		'      },' +
		'      {' +
		'        "name": "X-Google-Smtp-Source",' +
		'        "value": "AMrXdXvpxC2plgWYDb47IGRF9NXgFKUJ24YkOpokOgKYhXAWtIj+g2ibsP1lALfml5T8Qpc3Ie7SRs/tYY8nfV6x2Pw="' +
		'      },' +
		'      {' +
		'        "name": "X-Received",' +
		'        "value": "by 2002:a05:6512:36c4:b0:4b5:6417:644e with SMTP id e4-20020a05651236c400b004b56417644emr3038262lfs.495.1673290329680; Mon, 09 Jan 2023 10:52:09 -0800 (PST)"' +
		'      },' +
		'      {' +
		'        "name": "MIME-Version",' +
		'        "value": "1.0"' +
		'      },' +
		'      {' +
		'        "name": "From",' +
		'        "value": "Steven Altamirano \\u003csteven.altamirano.sf@gmail.com\\u003e"' +
		'      },' +
		'      {' +
		'        "name": "Date",' +
		'        "value": "Mon, 9 Jan 2023 21:51:59 +0300"' +
		'      },' +
		'      {' +
		'        "name": "Message-ID",' +
		'        "value": "\\u003cCADZv=gFbCED44qfPde=WyukssAGz8CCvHNEZCk_Qt8ehR8urYQ@mail.gmail.com\\u003e"' +
		'      },' +
		'      {' +
		'        "name": "Subject",' +
		'        "value": "Test"' +
		'      },' +
		'      {' +
		'        "name": "To",' +
		'        "value": "\\"test.public.api.sa@gmail.com\\" \\u003ctest.public.api.sa@gmail.com\\u003e"' +
		'      },' +
		'      {' +
		'        "name": "Content-Type",' +
		'        "value": "multipart/alternative; boundary=\\"000000000000b4ee5f05f1d943c1\\""' +
		'      }' +
		'    ],' +
		'    "body": {' +
		'      "size": 0' +
		'    },' +
		'    "parts": [' +
		'      {' +
		'        "partId": "0",' +
		'        "mimeType": "text/plain",' +
		'        "filename": "",' +
		'        "headers": [' +
		'          {' +
		'            "name": "Content-Type",' +
		'            "value": "text/plain; charset=\\"UTF-8\\""' +
		'          }' +
		'        ],' +
		'        "body": {' +
		'          "size": 7,' +
		'          "data": "VGVzdCENCg=="' +
		'        }' +
		'      },' +
		'      {' +
		'        "partId": "1",' +
		'        "mimeType": "text/html",' +
		'        "filename": "",' +
		'        "headers": [' +
		'          {' +
		'            "name": "Content-Type",' +
		'            "value": "text/html; charset=\\"UTF-8\\""' +
		'          }' +
		'        ],' +
		'        "body": {' +
		'          "size": 28,' +
		'          "data": "PGRpdiBkaXI9Imx0ciI-VGVzdCE8L2Rpdj4NCg=="' +
		'        }' +
		'      }' +
		'    ]' +
		'  },' +
		'  "sizeEstimate": 5076,' +
		'  "historyId": "1480",' +
		'  "internalDate": "1673290319000"' +
		'}';

	public static final MessageDto parsedMessage = MessageDto.parse(MESSAGE_RESPONSE);
}
