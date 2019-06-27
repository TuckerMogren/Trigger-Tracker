use_frameworks!
def shared_pods
	pod 'Firebase/Core'
	pod 'Firebase/Auth'
	pod 'Firebase/Storage'
	pod 'FirebaseFirestore', :inhibit_warnings => true
	#This next line will slience errors with protobuf
	pod 'Protobuf', :inhibit_warnings => true
	
end

target 'Trigger Tracker' do
  	#Pods for Trigger Tracker - iphone application
	platform :ios, '12.1'
  	shared_pods
end


target 'Trigger Tracker Watch Extension' do
	#pods for Trigger Tracker - watch extenstion application
	platform :watchos, '5.2'
	#shared_pods
end
	
