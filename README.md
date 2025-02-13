# Dancing Queen 👑
A Rails application that lets you chat with historical queens through AI

## Features
- Interactive conversations with historical queens
- AI-powered responses maintaining historical accuracy
- Random queen selection from database
- Responsive design with Tailwind CSS
- Clean, minimalist interface
- Easy deployment with Docker support

## Setup
```bash
git clone https://github.com/yourusername/dancing-queen.git
cd dancing-queen
bundle install
rails db:seed
npm install
```

## Configuration
Create a `.env` file in the root directory with your Deepseek API credentials:
```
DEEPSEEK_API_KEY=your_api_key_here
DEEPSEEK_API_URL=https://api.deepseek.com/v1
```

## Running the Application
```bash
rails server
```
Visit `http://localhost:3000` to start chatting with historical queens

## Requirements
- Ruby 3.4.1
- Node.js 18+
- SQLite3
- Deepseek API key

## Development
The application uses:
- Rails 8.0.1
- Tailwind CSS for styling
- Turbo and Stimulus for dynamic interactions
- Deepseek Ruby gem for AI integration

## License
MIT License
