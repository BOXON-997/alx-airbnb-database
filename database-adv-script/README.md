# Advanced Queries And Normalization

## join_queries.sql

The INNER JOIN only returns records where there is a matching user for each booking. If a booking has no valid user_id, it will not appear in the results.

The LEFT JOIN ensures that all properties appear in the results.
If a property has no review, the review columns will return NULL.

The FULL OUTER JOIN includes:
Users who have bookings
Users who don’t have any bookings
Bookings that don’t belong to any user
When there’s no match, the missing side will contain NULL values.

## for git below: 

git add .
git commit -m "Added the following files joins_queries.sql, README.md subqueries.sql, aggregations_and_window_functions.sql, index_performance.md, optimization_report.md, perfomance.sql, partition_performance.md, partitioning.sql, performance_monitoring.md and their content"

git push -u origin main