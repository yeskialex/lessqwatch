//
//  lessq_watch_newApp.swift
//  lessq_watch_new Watch App
//
//  Created by Yehezkiel Alexander on 10/9/25.
//

import SwiftUI
import UserNotifications

@main
struct lessq_watch_new_Watch_AppApp: App {
    init() {
        requestNotificationPermission()
        setupNotificationActions()
        _ = NotificationDelegate.shared
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    scheduleOffTrailNotification()
                    scheduleHeavyRainNotification()
                }
        }
    }

    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("Notification permission granted")
            } else {
                print("Notification permission denied")
            }
        }
    }

    private func setupNotificationActions() {
        let call119Action = UNNotificationAction(
            identifier: "CALL_119",
            title: "Call 119",
            options: [.foreground]
        )

        let cancelAction = UNNotificationAction(
            identifier: "CANCEL",
            title: "Cancel",
            options: []
        )

        let onMyWayAction = UNNotificationAction(
            identifier: "ON_MY_WAY",
            title: "On my way!",
            options: []
        )

        let rainCancelAction = UNNotificationAction(
            identifier: "RAIN_CANCEL",
            title: "Cancel",
            options: []
        )

        let offTrailCategory = UNNotificationCategory(
            identifier: "OFF_TRAIL_WARNING",
            actions: [call119Action, cancelAction],
            intentIdentifiers: [],
            options: []
        )

        let heavyRainCategory = UNNotificationCategory(
            identifier: "HEAVY_RAIN_WARNING",
            actions: [onMyWayAction, rainCancelAction],
            intentIdentifiers: [],
            options: []
        )

        UNUserNotificationCenter.current().setNotificationCategories([offTrailCategory, heavyRainCategory])
    }

    private func scheduleOffTrailNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Off-Trail Warning"
        content.body = "It looks like you've wandered from the main path. Let's get you back."
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "OFF_TRAIL_WARNING"

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        let request = UNNotificationRequest(identifier: "off-trail-warning", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            } else {
                print("Off-trail notification scheduled")
            }
        }
    }

    private func scheduleHeavyRainNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Heavy rain warning"
        content.body = "Descend from high ground immediately."
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "HEAVY_RAIN_WARNING"

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 80, repeats: true)
        let request = UNNotificationRequest(identifier: "heavy-rain-warning", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling heavy rain notification: \(error)")
            } else {
                print("Heavy rain notification scheduled")
            }
        }
    }

}
