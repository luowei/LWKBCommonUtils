# Graph Report - /Users/luowei/projects/libs/LWKBCommonUtils  (2026-05-04)

## Corpus Check
- Corpus is ~7,928 words - fits in a single context window. You may not need a graph.

## Summary
- 110 nodes · 124 edges · 10 communities detected
- Extraction: 96% EXTRACTED · 4% INFERRED · 0% AMBIGUOUS · INFERRED: 5 edges (avg confidence: 0.8)
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- [[_COMMUNITY_Community 0|Community 0]]
- [[_COMMUNITY_Community 1|Community 1]]
- [[_COMMUNITY_Community 2|Community 2]]
- [[_COMMUNITY_Community 3|Community 3]]
- [[_COMMUNITY_Community 4|Community 4]]
- [[_COMMUNITY_Community 5|Community 5]]
- [[_COMMUNITY_Community 6|Community 6]]
- [[_COMMUNITY_Community 7|Community 7]]
- [[_COMMUNITY_Community 8|Community 8]]
- [[_COMMUNITY_Community 9|Community 9]]

## God Nodes (most connected - your core abstractions)
1. `LWDataPipeManager` - 25 edges
2. `View` - 8 edges
3. `LWAppDelegate` - 7 edges
4. `SystemVersion` - 6 edges
5. `String` - 5 edges
6. `MainThreadModifier` - 4 edges
7. `UserDefaults` - 4 edges
8. `Tests` - 4 edges
9. `SafeAreaInsetsKey` - 3 edges
10. `DispatchQueue` - 3 edges

## Surprising Connections (you probably didn't know these)
- None detected - all connections are within the same source files.

## Communities (15 total, 2 thin omitted)

### Community 0 - "Community 0"
Cohesion: 0.13
Nodes (7): LWDataPipeManager, -getMyInputMethodAPPGroupValueByKey, -getUserDefaultValueByKey, -getValueByKey, -setMyInputMethodAPPGroupValuewithKey, -setUserDefaultValuewithKey, -setValuekey

### Community 1 - "Community 1"
Cohesion: 0.12
Nodes (12): AppGroupKey, AppGroupStorage, AppStorage, Color, DeviceInfo, EnvironmentValues, GeometryProxy, OrientationInfo (+4 more)

### Community 2 - "Community 2"
Cohesion: 0.15
Nodes (8): Bundle, CGFloat, CGRect, DeviceType, LWKBCommonUtils, ScreenDimensions, UserDefaults, Weak

### Community 3 - "Community 3"
Cohesion: 0.18
Nodes (4): AppConstants, Device, Screen, SystemVersion

### Community 4 - "Community 4"
Cohesion: 0.25
Nodes (4): dispatchMainSyncSafe(), DispatchQueue, MainThreadModifier, ViewModifier

### Community 6 - "Community 6"
Cohesion: 0.25
Nodes (7): LWAppDelegate, -applicationDidBecomeActive, -applicationDidEnterBackground, -applicationdidFinishLaunchingWithOptions, -applicationWillEnterForeground, -applicationWillResignActive, -applicationWillTerminate

### Community 8 - "Community 8"
Cohesion: 0.4
Nodes (4): Tests, -setUp, -tearDown, -testExample

### Community 9 - "Community 9"
Cohesion: 0.5
Nodes (3): LWViewController, -didReceiveMemoryWarning, -viewDidLoad

## Knowledge Gaps
- **30 isolated node(s):** `-getValueByKey`, `-setValuekey`, `-getUserDefaultValueByKey`, `-setUserDefaultValuewithKey`, `-getMyInputMethodAPPGroupValueByKey` (+25 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **2 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `dispatchMainSyncSafe()` connect `Community 4` to `Community 3`?**
  _High betweenness centrality (0.342) - this node is a cross-community bridge._
- **Why does `DispatchQueue` connect `Community 4` to `Community 2`?**
  _High betweenness centrality (0.329) - this node is a cross-community bridge._
- **Why does `UserDefaults` connect `Community 2` to `Community 0`?**
  _High betweenness centrality (0.280) - this node is a cross-community bridge._
- **What connects `-getValueByKey`, `-setValuekey`, `-getUserDefaultValueByKey` to the rest of the system?**
  _30 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Community 0` be split into smaller, more focused modules?**
  _Cohesion score 0.13 - nodes in this community are weakly interconnected._
- **Should `Community 1` be split into smaller, more focused modules?**
  _Cohesion score 0.12 - nodes in this community are weakly interconnected._