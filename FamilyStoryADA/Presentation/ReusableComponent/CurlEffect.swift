//
//  CurlEffect.swift
//  FamilyStoryADA
//
//  Created by Vincent Junior Halim on 07/10/24.
//

import SwiftUI
import UIKit

// Page View Controller Representable
struct PageViewController: UIViewControllerRepresentable {
    var viewControllers: [UIViewController]
    
    // Use `.pageCurl` transition style
    let transitionStyle: UIPageViewController.TransitionStyle = .pageCurl
    let navigationOrientation: UIPageViewController.NavigationOrientation = .horizontal

    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: transitionStyle,
            navigationOrientation: navigationOrientation,
            options: nil
        )
        
        pageViewController.dataSource = context.coordinator
        
        if let firstViewController = viewControllers.first {
            pageViewController.setViewControllers([firstViewController], direction: .forward, animated: true)
        }
        
        return pageViewController
    }
    
    func updateUIViewController(_ uiViewController: UIPageViewController, context: Context) {
        // No update logic needed for this simple example
    }
    
    // Coordinator to handle page transitions
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIPageViewControllerDataSource {
        var parent: PageViewController
        
        init(_ parent: PageViewController) {
            self.parent = parent
        }
        
        // Return the view controller before the current one
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let index = parent.viewControllers.firstIndex(of: viewController), index > 0 else {
                return nil
            }
            return parent.viewControllers[index - 1]
        }
        
        // Return the view controller after the current one
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = parent.viewControllers.firstIndex(of: viewController), index < parent.viewControllers.count - 1 else {
                return nil
            }
            return parent.viewControllers[index + 1]
        }
    }
}

struct TestView: View {
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.red)
            Text("LU E MAK SIAO")
                .font(.largeTitle)
                .foregroundColor(.white)
                    }.ignoresSafeArea(.all)
    }
}

struct PageCurlView: View {
    var body: some View {
        PageViewController(viewControllers: [
            UIHostingController(rootView: TestView()),
            UIHostingController(rootView: Color.green),
            UIHostingController(rootView: Color.blue)
        ])
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView: View {
    var body: some View {
        PageCurlView()
            
    }
}

#Preview {
        ContentView()
}
