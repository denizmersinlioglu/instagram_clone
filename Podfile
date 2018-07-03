project 'RiseApp.xcodeproj'
platform :ios, '9.0'
use_frameworks!


def default_pods
    pod 'Firebase/Auth'
    pod 'Firebase/Database'
    pod 'Firebase/Storage'
    pod 'MaterialComponents', "~> 55"
    pod 'expanding-collection'
end

target 'RiseApp' do
    default_pods
end

def test_pods
    pod 'Quick', "~> 1"
    pod 'Nimble', "~> 7"
end

target 'RiseAppTests' do
    test_pods
    default_pods
end

target 'RiseAppUITests' do
    default_pods
end


