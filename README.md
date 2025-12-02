# GuildList
Addon for WoW 1.12 so you easy can insert all guild members into a Google sheet.  

### Where do I find the data I need ?
\WoW Folder\WTF\Account\\[ACCOUNT NAME]\\[SERVER NAME]\\[CHARACTER NAME]\SavedVariables\GuildList.lua

### How to use in Google Sheet ?
Where you want the list to be you just add:  
**=ARRAYFORMULA(TRIM(SPLIT(TRANSPOSE(SPLIT(H2; "-")); ",")))**  
And the data from the addon will be added in H2 (or where ever you prefeer)

### Why would I ever want to use this ?
No idea, I use it to easy make a list in the sheet we need.  
If you don't know why, then don't install. ;)
