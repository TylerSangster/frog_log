FactoryGirl.define do
  factory :user do
<<<<<<< HEAD
    first_name            "Tyler"
    last_name             "Sangster"
    email                 "tyler.sangster@gmail.com"
    password              "foobar"
    password_confirmation "foobar"

    factory :user_two do
      first_name            "Najwa"
      last_name             "Azer"
      email                 "najwa.azer@gmail.com"
      password              "foobar"
      password_confirmation "foobar"
    end
=======
    first_name						"Tyler"
    last_name							"Sangster"
    email    							"tyler.sangster@gmail.com"
    password 							"foobar"
    password_confirmation "foobar"

    factory :user_two do
	    first_name						"Najwa"
	    last_name							"Azer"
	    email    							"najwa.azer@gmail.com"
	    password 							"foobar"
	    password_confirmation "foobar"
	  end
>>>>>>> 1e68820592a6af294b9224ca84034acb9f3e9a1b

    factory :admin_user do
      first_name            "Admin"
      last_name             "User"
      email                 "admin@example.com"
      password              "foobar"
      password_confirmation "foobar"
      admin                 true
    end
  end
<<<<<<< HEAD
  factory :review do
    user               
    score                   5
    title                   "This is a review"
    content                 "Hello, this is a review. Hello, this is a review. Hello, this is a review. Hello, this is a review. "
  end
=======
>>>>>>> 1e68820592a6af294b9224ca84034acb9f3e9a1b
end