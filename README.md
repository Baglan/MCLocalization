# MCLocalization

Set of tools to simplify "on the fly" localization in iOS apps.

## Reasons

There is the "standard" way Apple of localizing iOS apps using  __NSLocalizedString__. It's versatile enought and you should stick to it unless you have good reasons not to.

I reuse the same localization files in an iOS app, on a web site and, possibly, in an app made for another platform. Advantage of JSON there is that libraries for handling JSON are available for just about any modern platform.

As a side advantage, it is much easier to create tools which do not rely on localizers being proficient with escaping C strings or use translation services not geared towards iOS app localization.

## File format

MCLocalization uses strings files in JSON format. Internally, it is a collection of collections of strings. Here's an example from the sample project:  

	{
	    "en": {
	        "greeting": "Hello!",
	        "message": "Tap on the buttons below to switch languages"
	    },
	    "ru": {
	        "greeting": "Привет!",
	        "message": "Нажимайте на кнопки для смены языка"
	    }
	}
	
Collection of strings for each language is referenced by a  canonicalized IETF BCP 47 language identifier (the same identifier used in NSLocale). Strings in a collection are further identified by keys.

## Installation

Add files from the 'Classes' folder to your project.

## Usage

Initialize localization by loading strings:

```objective-c	
NSString * path = [[NSBundle mainBundle] pathForResource:@"strings.json" ofType:nil];
   [MCLocalization loadFromJSONFile:path defaultLanguage:@"en"];
```

MCLocalization will try to determine the best mathing language based on device's language preferences, defaultLanguage prameter is a "fall-through" setting in case there is no match.

Here's how you fetch a localized string:

```objective-c	
_label.text = [MCLocalization stringForKey:@"greeting"];
```

MCLocalization was designed to aid "instant" localization so that app's UI could update right after, user updates the language setting. To update the localization language, set it like this:

```objective-c
[MCLocalization sharedInstance].language = @"ru";
```

Localization language will be set and a __MCLocalizationLanguageDidChangeNotification__ notification will be send. This setting is stored in user defaults and next time app is launched, this setting will be used.

## Recommended usage pattern

For using MCLocalization, I recommend this pattern:

Load localization strings in AppDelegate __application:didFinishLaunchingWithOptions:__:

```objective-c
NSString * path = [[NSBundle mainBundle] pathForResource:@"strings.json" ofType:nil];
[MCLocalization loadFromJSONFile:path defaultLanguage:@"en"];
```

In UIViewController you want to localize, collect all the localization code in a dedicated function:

```objective-c
- (void)localize
{
    _greetingLabel.text = [MCLocalization stringForKey:@"greeting"];
    _messageLabel.text = [MCLocalization stringForKey:@"message"];
}
```

Call that function from the __viewDidLoad__ and add view controller as an observer for the __MCLocalizationLanguageDidChangeNotification__:

```objective-c
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localize) name:MCLocalizationLanguageDidChangeNotification object:nil];
[self localize];
```

## License

Code in this project is available under the MIT license.