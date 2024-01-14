select roll_number, student_name, class, section, school_name, math_correct, math_wrong, math_yet_to_learn, math_score, round((math_correct::decimal/total_math_question::decimal)*100,2) as math_percentage,
		Science_correct, Science_wrong, Science_yet_to_learn, Science_score, round((Science_correct::decimal/total_Science_question::decimal)*100,2) as Science_percentage
from(Select sl.roll_number, sl.student_name, sl.class, sl.section, sl.school_name,
		sum(case when pc.subject = 'Math' and sr.option_marked = ca.correct_option and sr.option_marked <> 'e'
			then 1 else 0 end ) as  math_correct,
		sum(case when pc.subject = 'Math' and sr.option_marked <>	ca.correct_option and sr.option_marked <> 'e'
				then 1 else 0 end ) as  math_wrong,
		sum(case when pc.subject = 'Math' and sr.option_marked ='e'
						then 1 else 0 end ) as  math_yet_to_learn,
		sum(case when pc.subject = 'Math' and sr.option_marked = ca.correct_option and sr.option_marked <> 'e'
							then 1 else 0 end ) as  math_score,
		sum(case when pc.subject = 'Math'	then 1 else 0 end ) as  total_math_question,

		sum(case when pc.subject = 'Science' and sr.option_marked = ca.correct_option and sr.option_marked <> 'e'
			then 1 else 0 end ) as Science_correct,
		sum(case when pc.subject = 'Science' and sr.option_marked <>	ca.correct_option and sr.option_marked <> 'e'
				then 1 else 0 end ) as  Science_wrong,
		sum(case when pc.subject = 'Science' and sr.option_marked ='e'
						then 1 else 0 end ) as Science_yet_to_learn,
		sum(case when pc.subject = 'Science' and sr.option_marked = ca.correct_option and sr.option_marked <> 'e'
							then 1 else 0 end ) as  Science_score,
		sum(case when pc.subject = 'Science' then 1 else 0 end ) as  total_science_question
from student_list sl
join student_response sr on sl.roll_number = sr.roll_number
join correct_answer ca on sr.question_paper_code = ca.question_paper_code and ca.question_number = sr.question_number
join question_paper_code pc on ca.question_paper_code = pc.paper_code
--	where sr.roll_number = 10159
group by sl.roll_number, sl.student_name, sl.class, sl.section, sl.school_name)




--select * from student_list
--select * from student_response
--select * from correct_answer
--Select * from question_paper_code
