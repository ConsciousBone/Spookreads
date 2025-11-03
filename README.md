# Spookreads
Spookreads is an iOS/iPadOS app for generating short(ish) spooky(ish) stories using AI, built for Hack Club's Siege Week 9.  
It supports iPhone and iPad, as well as Mac and Apple Vision Pro using *Designed for iPad*!

# Proxy down?
My server likes to occaisionally shut itself down for no real reason, I blame Proxmox.
If the API requests fail for some reason, you are actually connected to the internet, and you have tried all of the regular troubleshooting steps (including turning it off and on again), then ping me on Slack or email me at `evan@consciousb.one` and I'll get it working again ASAP!

# Demos
## Screenshots
<img src="/Screenshots/1.png" width=128> <img src="/Screenshots/2.png" width=128> <img src="/Screenshots/3.png" width=128>
<img src="/Screenshots/4.png" width=128> <img src="/Screenshots/5.png" width=128> <img src="/Screenshots/6.png" width=128>
<img src="/Screenshots/7.png" width=128> <img src="/Screenshots/8.png" width=128> <img src="/Screenshots/9.png" width=128>
<img src="/Screenshots/10.png" width=128> <img src="/Screenshots/11.png" width=128> <img src="/Screenshots/12.png" width=128>
<img src="/Screenshots/13.png" width=128>
## Video
[YouTube link (unlisted)](https://youtu.be/rsNRq54jlAo)

# Backend (proxy server)
The backend to this is powered by Nginx, and is the same backend as Leafy, my Siege Week 8 project that logs and identifies leaves found by the user. It's still all hosted locally at my house and running on Ubuntu Desktop 25.04 inside of Proxmox!  
Since it is the *exact* same backend that Leafy used, a more detailed explanation of it can be found over at [Leafy's GitHub repo](https://github.com/ConsciousBone/Leafy).  
Or for more information, see the repo for the backend [here](https://github.com/ConsciousBone/LeafyNginxConfig).

# How to get Spookreads
This is the way I recommend, but there are other ways to sideload apps onto iOS/iPadOS devices and they will work for Spookreads, I'm just using Sideloadly as an example.  
1. Install [Sideloadly](https://sideloadly.io/) and its dependencies; if I remember correctly macOS has none but Windows needs iTunes and iCloud **not from the Microsoft Store!**. The Sideloadly website will link you to the requirements for your OS.  
2. From the [Releases](https://github.com/ConsciousBone/Spookreads/releases/tag/stable) tab, find the latest release - it should be the first one at the top - and download the attached `Spookreads.ipa` file.
3. Using a cable that supports both charging *and* data transfer, connect your device (iPhone or iPad, the sideloading process for Macs and AVPs is different) to your computer, select `Trust` and enter your passcode if prompted, and open Sideloadly.
4. In Sideloadly, click the file icon with the `IPA` text amd select the previously downloaded `Spookreads.ipa` file.
5. Select your device in the `iDevice` dropdown, and make sure the name matches with the device you wish to sideload Spookreads to. 
6. Enter your Apple Account/ID's email into the `Apple ID` text field. If you are using a free developer account, you will have to resign/reinstall the app every 7 days, but if you use a paid developer account this goes up to a very nice 365 days!  
7. Click the `Start` button, and enter your Apple Account/ID's password when prompted to. **This password goes straight to Apple and no one else apart from you and Apple ever see it; not the Sideloadly developers and not me.**
8. Wait for the app to install, and then launch it! *If you are prompted to enable Developer Mode or trust the app, do so.*

# Inspiration
I have always thought that AI can write decently well - albeit that it shouldn't really ever be used to write stuff outside of anything for personal use - and with my previous project requiring me to purchase a total of £10 of OpenAI credits, I figured I may as well put them to good use and make yet another AI based app for week 9; combine that with the theme being `Spooky` (because it was Halloween recently) and boom, AI spooky story generator!

# Tech stack
- Swift (what practically every modern iOS/iPadOS app is written in)
- SwiftUI (for the whole of the app's UI)
- SwiftData (to store the stories, duh)
- OpenAI API (on the backend, actually writes the stories and sends them back to us! I'm using `gpt-4o-mini` for Spookreads because it's cheap and also pretty fast)
- Nginx (on the backend, proxies the requests from my server to OpenAI so I don't leak my API key)
