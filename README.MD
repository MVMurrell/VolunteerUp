## MIDTERM GROUP PROJECT

Created by:
Jimmy Fruchterman - Scrum Master
Mike Murrell - Git Repo Owner
Braiden Miller - DBA

Link to project on AWS: link

## Description

We built a website called "VolunteerUp". This website lets you plan or join
projects to improve your community, whether it's cleaning up a dirty walking
path, landscaping a park, fixing potholes, saving the whales, it's up to you!

Our website allows you to register, create a profile, login/logout, join or
leave projects, create projects, comment on them, and if you have permission,
edit or delete projects, comments, and volunteers. We also have an admin role
that allows you special permissions to edit projects or volunteers on the site.
The website also allows you to track the hours volunteers have pledged and
contributed to the project, and also tools and skills needed by the project and
provided by volunteers.

## How to use

From the home page you have a couple of options to interact with the website.
You have the choice to search the existing projects in the database by keyword.
Type the keyword you would like to search by in the search field under "Search
by Keyword(s)" and press the green search button directly under the field. You
can also list projects by one or multiple categories by selecting categories
from a group of checkboxes. Your list of results will populate below the large
picture with each project's vital information listed. To learn more about a
project, press the green "View Project" below the project description.

If this is your first time visiting VolunteerUp you will want to register and
create an account. In the top right hand corner press the "Login/Register" icon
to proceed to the respective page. At the Login/Register page you have a choice
on the right to "Create Account". In future visits, after you create an account,
you will return to this page to sign in with your username and password.

Click the "Create Account" button. Enter your email address, username, and
password in their respective fields and continue to enter further information to
set up your account on the following page. Press Submit and your profile is
created. You are now capable of creating projects, joining projects, and leaving
comments you are a part of. From your profile page you are able to see the
projects you are in along with the projects you are the lead of.

Choose a project by clicking its "View Project" button. You will be brought to
the project's information page where you can view all of the project's details.
If you are a volunteer viewing a project you are not a part of you can enter the
hours you will pledge to contribute to the project and select join project.
After you have joined you can edit the hours you are contributing or remove
yourself from the project. If you are the project owner you will have the
ability to remove volunteers, edit their hours, edit the project details, and
cancel the event by setting it to inactive. These privileges are also given to
the admin when viewing any project on the site.

## Requirements

Our website was created to satisfy the following requirements of our midterm
project:

- A fully developed database schema. The database must be connected to your Java
code using JPA.
- Our friend C.R.U.D, this time manipulating objects and saving them in an
appropriate database table.
- A user log in, which is authenticated by a mySQL table. There should be
different permission levels for the users, one admin that can add/update/delete
content present on the site.
- A correct implementation of a session object, this can be used to track a
logged in user and any changes they make (for example, a shopping cart or
favorites list).
- A way to track an individual user's previous experiences on the site. For
example if it is a food ordering system, a list of previous orders.

## Technology Used

SpringMVC with SpringBoot, JPA, MySQL, CRUD, HTML, CSS, JSP, Bootstrap, AWS.

## Stretch goals

Accomplished:
- See other user's profiles
- Comments on projects (add, remove)
- Project has location map (google maps API)
- User can associate with a company
- Can cancel project, see if it was cancelled

Ran out of time:
- Hash-coded password
- User can filter projects by date
- User reputation tracker (actual hours vs. pledged, etc.)
- Map on homepage showing pins for various projects
- Project recommendations based on skills, past project interest
