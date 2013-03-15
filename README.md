# MCLocalization

Set of tools to simplify "on the fly" localization in iOS apps.

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
	
	NSString * path = [[NSBundle mainBundle] pathForResource:@"strings.json" ofType:nil];
    [MCLocalization loadFromJSONFile:path defaultLanguage:@"en"];

MCLocalization will try to determine the best mathing language based on device's language preferences, defaultLanguage prameter is a "fall-through" setting in case there is no match.

Here's how you fetch a localized string:
	
	_label.text = [MCLocalization stringForKey:@"greeting"];

MCLocalization was designed to aid "instant" localization so that app's UI could update right after, user updates the language setting. To update the localization language, set it like this:

	[MCLocalization sharedInstance].language = @"ru";

Localization language will be set and a __MCLocalizationLanguageDidChangeNotification__ notification will be send. This setting is stored in user defaults and next time app is launched, this setting will be used.

## Recommended usage pattern

For using MCLocalization, I recommend this pattern:

Load localization strings in AppDelegate __application:didFinishLaunchingWithOptions:__:

&nbsp;

```objective-c
	NSString * path = [[NSBundle mainBundle] pathForResource:@"strings.json" ofType:nil];
	[MCLocalization loadFromJSONFile:path defaultLanguage:@"en"];
```

In UIViewController you want to localize, collect all the localization code in a dedicated function:

&nbsp;

	- (void)localize
	{
	    _greetingLabel.text = [MCLocalization stringForKey:@"greeting"];
	    _messageLabel.text = [MCLocalization stringForKey:@"message"];
	}

Call that function from the __viewDidLoad__ and add view controller as an observer for the __MCLocalizationLanguageDidChangeNotification__:

&nbsp;

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localize) name:MCLocalizationLanguageDidChangeNotification object:nil];
    
    [self localize];


## License

Code in this project is available under the MIT license.