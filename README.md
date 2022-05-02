# BarakaNewsFeed
This repo contains stock market news feed

## Remarks

- Architucture used in this project is MVVM with Protocol Oreianted Programming % RxSwift
- All features are reseliante for provider change (content datasource, image cache, loader)
- Full depenency injection for when applicable
- Two environments running schemes (Develop, Local) 
- Clean folder organization

## How to run

- Clone the repo
- Open BarakaTest.xcodeproj
- Resolve SPM dependencies
- Choose the scheme and run the project
- To fethc the data locally, please use Local scheme
- To fethc the hosted data from server, please use Develop scheme
### Third party dependencies

I've used SPM for below dependencies
- Kingfisher for web image caching  (https://github.com/onevcat/Kingfisher)
- MBProgressHUD for adding hud loader (https://github.com/jdg/MBProgressHUD)
- CSV for parsing csv files (https://github.com/yaslab/CSV.swift)
- RxSwift for reactive programing (https://github.com/ReactiveX/RxSwift)

## Screenshots


Uploading Simulator Screen Recording - iPhone 12 Pro - 2022-05-02 at 08.08.33.mp4…

![Simulator Screen Shot - iPhone 12 Pro - 2022-05-02 at 07 57 31](https://user-images.githubusercontent.com/39689007/166188248-52b8ded2-83fe-40be-ac0d-15f7ed3b3586.png)
