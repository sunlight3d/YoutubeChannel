# flutterapp
Write Flutter UI Screen with:
-Left Drawer
-5 Bottom Tabs(Watchlist, Market, Trading, Assets, Cash Transfer) with icons
-Bottom tabs has gray background color, when user press to each tab, icon's color will be "green"
-Each screen in separated files
-Use const for better performance


In FLutter, assume that we have 1 screen with multiple widget. Each widget is in a separated file. Which best way to call this screen inside main

Write a Flutter screen, remove AppBar, replace AppBar with a Row which contains(from left to right):
Button with menu icon: When user press this, a Drawer is opened
A TextField with search icon and hint: Search/Add/Remove Symbol
A Button with Bell icon 

Giải thích về các thuật ngữ: Index, Derivatives, Cover Warrants, ETF, Top Stock trong đầu tư chứng khoán

Code a Flutter widget:
-Has 15 rows, below the final row is a Text, center
-Table's header is: Symbol, Price, +/-, +/- %, TotalVol, can be pressed
-Data is faked, fetched to an object

give me name of 20 industries in securities investment

Write Flutter code to do:
In MainWidget, we have a button
When we press this button,Show a ChilldWidget popup (fadein),
this popup widget will disappear if user touch outside the popup
The ChilldWidget has the opacity of 70%


Write a Flutter widget contains a list of strings:
Padding start/end: 20
Data list is from parent widget:
Software & Services
Technology Hardware & Equipment
Semiconductors & Semiconductor Equipment
Pharmaceuticals
Biotechnology
Medical Devices & Supplies
Banking
Insurance
Asset Management & Custody Banks
Automobiles & Components
Consumer Durables & Apparel
Retailing
Food & Staples Retailing
Household & Personal Products
Oil, Gas & Consumable Fuels
Energy Equipment & Services
Electric Utilities
Metals & Mining
Chemicals
Wireless Telecommunication Services 

I have a Left Drawer in Flutter app, write UI of the Drawer as follow:
First row is a image logo(local png file, aligh left, margin start 20), a wrapped text named "Welcome to my App",
Next row is 2 Buttons: Login, Register, border radius 5, grey border
Next row is [an Icon][text: Get Smart OTP]
The remain rows, if user press each Row, the row's background color will be "green":
[an Icon][text: Price board]
[an Icon][text: Watch list]
[an Icon][text: Industry]
[an Icon][text: Top stocks]
[an Icon][text: Notification]
A line here, margin vertically: 10
[an Icon][text: Equities Trading]
[an Icon][text: Derivatives Trading]
[an Icon][text: Right Trading]
[an Icon][text: S-Products]
[an Icon][text: Cash Transaction]
[an Icon][text: Assets Management]
[an Icon][text: Account Management]
A line here, margin vertically: 10
[an Icon][text: Abc Plus]
[an Icon][text: Settings]
[an Icon][text: Contact]


Write code to make Flutter screen named "Settings" with:
First row(background: grey, higher than other rows): [text: General, color: black grey]
Next row(background: white): [text: Language, color: black, text: English, icon: "right arrow"]
Next row(background: white): [text: Theme, color: black, text: Light, icon: "right arrow"]
Next row(background: white): [text: Order Confirmation, color: black, a "switcher widget"]
Next row(background: white): [text: Notification, color: black, text: , icon: "right arrow"]
Next row(background: grey, higher than other rows): [text: Security, color: black grey]
Next row(background: white): [text: Two factors authentication, color: black, text: ,icon: "right arrow"]
Next row(background: white): [text: Smart OTP, color: black, text: ,icon: "right arrow"]
Next row(background: white): [text: Authenticate with Fingerprint, color: black, a "switcher widget"]
Next row(background: grey, higher than other rows): [text: Display, color: black grey]
Next row(background: white): [text: Format, color: black, text: ,icon: "right arrow"]
Next row(background: white): [text: Index Quick Bar, color: black, text: ,icon: "right arrow"]
Next row(background: white): [text: Order Condition, color: black, a "switcher widget"]
Next row(background: grey, higher than other rows): [text: About this App, color: black grey]
Next row(background: white): [text: Rate us, color: black, text: ,icon: "right arrow"]
Next row(background: white): [text: Privacy & Disclaimer, color: black, text: ,icon: "right arrow"]
Next row(background: white): [text: App Version, color: black, text: ,icon: "right arrow"]
Every row can be touchable, when it is touched, print a console message
use const for better performance
if switcher toggles, save to states


When I press to an Item in a left drawer in Flutter, it navigate to SettingsScreen, how can I do that ?

I have a Flutter App with several screens(more than 3 screens),
In setting screen, we have a text:"Dark mode", then an on/off switcher
When I set the dark mode to ON, all screens of my app become "dark"
How can I implement this in Flutter ?

- 


