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



https://user-images.githubusercontent.com/39689007/166187932-48bdaaad-a52e-47e7-9d13-fdf90c1560cb.mp4

![Simulator Screen Shot - iPhone 12 Pro - 2022-05-02 at 07 57 31] | (https://user-images.githubusercontent.com/39689007/166187286-9d275597-905f-4fd6-97d4-4263d57938b8.png)
