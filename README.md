# Welcome to Videoclub!

Videoclub is a cutting-edge web application inspired by IMDb but enhanced with AI-driven search capabilities and tailored recommendations. Built with Rails 7.1.3.4 and Stimulus JS, this platform offers a unique interface for exploring and organizing your favorite movies.

## Features

- **AI Search**: Utilize AI-powered search to find four movies based on user queries.
- **User Lists**: Add movies to favorites, watch later, already watched, or custom lists.
- **Recommendations**: Click on "Find Similar" in the favorites section to discover new movies based on genre, ratings, and AI analysis through the OpenAI/ChatGPT 4o model.

## Installation

### Prerequisites

- PostgreSQL
- Ruby 3.1.2
- Ruby on Rails 7.1.3.4

### Setup

1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourgithub/videoclub.git
   cd videoclub
   ```
   
2. **Install Ruby and JavaScript dependencies**:
   ```bash
   bundle install
   yarn install
   ```
   
3. **Setup the database**:
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```
   
4. **Obtain API keys for OMDB, TMDB, and OpenAI** and set them as environment variables or in your credentials file.

### Running Locally

To start the Rails server, run:
```bash
rails s
```
Navigate to `http://localhost:3000` to see the application in action.

## Usage

Explore the application to search for movies, add them to various lists, and discover similar content through AI-driven suggestions. The intuitive UI and responsive design cater to desktop usage.

## Contributing

We are open to contributions! If you have ideas or improvements for Videoclub, please contact us at `[your-email]` to discuss how you can contribute. We appreciate prior communication to align contributions with our project vision.

## Credits

- **Killian**: [GitHub/Killian](https://github.com/Killrian47)
- **Benoit**: [GitHub/Benoit](https://github.com/benoit-korben)
- **Ismaël**: [GitHub/Ismael](https://github.com/ismaeljouhariperez)

## License

This project is currently open source and free to use under the terms of the MIT license.