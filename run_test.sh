output="../build/ios_integ"
product="build/ios_integ/Build/Products"

# Pass --simulator if building for the simulator.
flutter build ios integration_test/foo_test.dart --release

pushd ios
xcodebuild -workspace Runner.xcworkspace -scheme Runner -config Flutter/Release.xcconfig -derivedDataPath "`pwd`/../build/ios_integ" -sdk iphoneos build-for-testing
popd

pushd "build/ios_integ/Build/Products"
zip -r "ios_tests.zip" "Release-iphoneos" "Runner_iphoneos14.5-arm64.xctestrun"
popd

#gcloud firebase test ios run --test "build/ios_integ/ios_tests.zip" --device model=iphone12pro,version=14.5,locale=fr_FR,orientation=portrait
