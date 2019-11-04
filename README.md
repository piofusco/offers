# Interview for Ibotta

### 🛠 Setup 🛠

1. `carthage update --platform ios --no-use-binaries`
2. `bundle install`

#### 🏞 Environment Variables 🏞

In order for Fastlane to be able to use Match and TestFlight, you'll need values for the following in your `.bash_profile`.

```
export APP_STORE_CONNECT_ID="yourAppleIdEmail@gmail.com"
export TEAM_ID="yourTeamId"

```

Dependencies
1. KingFisher (https://github.com/onevcat/Kingfisher) - downloading + caching images
2. Quick (https://github.com/Quick/Quick) - BDD style testing framework
3. Fastlane (https://fastlane.tools/) - app automation
4. Snapkit (https://github.com/SnapKit/SnapKit) - DSL for programmatic views
5. Carthage (https://github.com/Carthage/Carthage) - decentralized dependency manager

### 🧪 Tests 🧪

Unit: `fastlane unit_tests`

UI: `fastlane unit_tests`

All:  `fastlane tests`

### 🔑 Code Signing [with Match](https://codesigning.guide/) 🔑

This project is configured to have Fastlane/Match handle code signing. All of the certificates live in a [private repository](https://github.com/piofusco/offers-certificates). 

### ⚙️ Continuous Integration/Deployment ⚙️

This project is setup to deploy to TestFlight through [CircleCi 2.0 and Workflows](https://circleci.com/gh/piofusco/offers). Here's a short break down of what _happens each time a commit is pushed to master (no matter the branch)_(for more info, checkout the `config.yml`:

1. Build dependencies
- checkout repo
- Install/cache Gems
- Install/cache Carthage dependencies
2. Run Unit and UI tests in parallel
3. Deploy to TestFlight
- commit a build number bump

### 🚀 Manually Deploying 🚀

To deploy a build manually, simply run `bundle exec fastlane beta`.
