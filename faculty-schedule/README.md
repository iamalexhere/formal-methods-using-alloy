# Problem
A faculty wants to model a lecture scheduling system that includes:
- A group of lecturers
- Several courses taught by each lecturer
- Time (hour slots per day)
- Classroom
Each course:
- Can only be scheduled once a week
- There must be no schedule collisions, ie:
- Two courses may not occupy the same space and time
- Lecturers may not teach two courses at the same time

# Answer
[See the formal specification and solution in Alloy](faculty-schedule.als)