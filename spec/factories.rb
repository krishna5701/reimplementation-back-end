FactoryBot.define do
  factory :update_participant do
    
  end

  factory :sign_up_topic do
    
  end

  factory :user do
    sequence(:name) { |_n| Faker::Name.name.to_s.delete(" \t\r\n").downcase }
    sequence(:email) { |_n| Faker::Internet.email.to_s }
    password { 'password' }
    sequence(:full_name) { |_n| "#{Faker::Name.name}#{Faker::Name.name}".downcase }
    role factory: :role
    institution factory: :institution
  end

  factory :role do
    name { Faker::Name.name }
  end

  factory :assignment do
    sequence(:name) { |n| "assignment#{n}" }
    directory_path {"final_test"}
  end

  factory :team, class: Team do
    id {1}
    name {'testteam'}
    parent_id {1}
  end

  factory :assignment_team, class: AssignmentTeam do

  end

  factory :review_response_map, class: ReviewResponseMap do
    assignment { Assignment.first || association(:assignment) }
    reviewer { AssignmentParticipant.first || association(:participant) }
    #reviewee { AssignmentTeam.first || association(:assignment_team) }
    #type {'ReviewResponseMap'}
    #calibrate_to 0
  end



  factory :response, class: Response do
    #response_map { ReviewResponseMap.first || association(:review_response_map) }
    #additional_comment nil
    #version_num nil
    #round {1}
    is_submitted {false}
    #visibility {'private'}
  end


  factory :invitation do
    from_user factory: :user
    to_user factory: :user
    assignment factory: :assignment
    reply_status { 'W' }
  end

  factory :institution, class: Institution do
    name {'North Carolina State University'}
  end

  if ActiveRecord::Base.connection.table_exists?(:roles)
    factory :role_of_instructor, class: Role do
      name { 'instructor' }
      parent_id { nil }
    end
  end

  factory :role_of_student, class: Role do
    name { 'student' }
    parent_id { nil }

  end

  factory :instructor, class: Instructor do
    name {'instructor'}
    role { Role.where(name: 'instructor').first || association(:role_of_instructor) }
    password { 'password' }
    full_name { 'instructornew' }
    parent_id { User.first || association(:user) }
    email {'instructor6@gmail.com'}

  end

  factory :course, class: Course do
    instructor { Instructor.first || association(:instructor) }
    sequence(:name) { |n| "user_#{n}" }
    directory_path {'csc517/test'}
    info {'Object-Oriented Languages and Systems'}
    private {true}
    institution { Institution.first || association(:institution) }
  end


  factory :participant, class: AssignmentParticipant do
    assignment { Assignment.first || association(:assignment) }
    association :user, factory: :student
    type { 'AssignmentParticipant' }
    handle { 'handle' }
  end

  factory :course_participant, class: CourseParticipant do
    course { Course.first || association(:course) }
    association :user, factory: :student
    type { 'CourseParticipant' }
    handle { 'handle' }
  end
  factory :assignment_participant, class: AssignmentParticipant do
    assignment { Assignment.first || association(:assignment) }
    association :user, factory: :student
    type { 'AssignmentParticipant' }
    handle { 'handle' }
  end
  factory :student, class: User do
    # Zhewei: In order to keep students the same names (2065, 2066, 2064) before each example.
    name {'studentname'}
    role { Role.where(name: 'student').first || association(:role_of_student) }
    full_name { 'studentnew' }
    password { 'password' }
    email { 'expertiza@mailinator.com' }
    parent_id { 1 }
    mru_directory_path { nil }
    email_on_review { true }
    email_on_submission { true }
    email_on_review_of_review { true }
    is_new_user { false }
    master_permission_granted { 0 }
    handle { 'handle' }
    copy_of_emails { false }
  end

end