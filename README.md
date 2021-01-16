# DutyStation - API

This is an unfinished attempt at making a backend for a Trello-clone. It was inspired by our dissatisfaction with Trello as a service and a desire for a task management board that had more focused functionality. However, as with almost all my side-projects, this became overshadowed by more profitable work and the discovery of other open source alternatives to Trello.

The frontend is a separate project that will remain private for the foreseeable future. Conceivably, if I were to restart development I could use any frontend framework out there, but I had decided on React at the time because of the npm package [@lourenci/react-kanban](https://www.npmjs.com/package/@lourenci/react-kanban). It provides most of the functionality of a kanban board though its interface is continually in flux and the documentation is a work in progress. Such is life for the JavaScript ecosystem.

## State of the Test Suite

Currently there is no test suite other than what the generators provided. At the time I was more focused on getting something that worked and then going back to see what assumptions I had made and codifying them with appropriate tests. For the most part the models and controllers are straightforward, with the Status model needing a test for its before_create hook to ensure it does set the order for itself and the records around it. Tasks and Projects would have eventually needed that as well if they had gotten further development.

## Setup

It is assumed that a Ruby environment manager like RVM or rbenv is being used. The repository is not set up for asdf in mind at the moment. The ruby version to install is referenced in `.ruby-version`.

Run `bundle install` to set up dependencies.

PostgreSQL is used for the database. It is assumed that you know how to configure the database system.

The file `env-template` should be copied and the copy renamed to `.env`. This project uses the `dotenv` gem to load the environment variables from that file into the environment. Configure your environment there.

Once the environment is set up the database can be created by running `bin/rails db:setup`.

## Running the dev server

`bin/rails s`
