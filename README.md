# Conflicting Events
Load a static list of events, order them by date, section them by day and also visually indicate conflicting events with a time complexity better than O(n<sup>2</sup>).

# Solution
Use an Interval Tree to achieve O(nLogn) for the tree creation and O(nLogn) for the conflict detection.
