import express from 'express';
import path from 'path';

const app = express();

const publicPath = path.join(process.cwd(), '.public');
app.use('/public', express.static(publicPath));

app.get('*', (req, res) => {
  res.send(`
    <!DOCTYPE html>
    <html>
      <head>
        <meta charset="utf-8">
        <title>Elm News</title>
      </head>
      <body>
        <div id="root"></div>
        <script src="/public/bundle.js"></script>
      </body>
    </html>
  `);
});

export default app;
