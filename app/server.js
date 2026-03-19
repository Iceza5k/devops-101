const http = require("http");
const os = require("os");

const port = process.env.PORT || 3000;
const message = process.env.APP_MESSAGE || "Hello from DevOps 101";

const server = http.createServer((req, res) => {
  if (req.url === "/health") {
    res.writeHead(200, { "Content-Type": "application/json" });
    res.end(JSON.stringify({ status: "ok" }));
    return;
  }

  res.writeHead(200, { "Content-Type": "application/json" });
  res.end(
    JSON.stringify(
      {
        app: "devops101-demo-app",
        message,
        hostname: os.hostname(),
        method: req.method,
        path: req.url,
      },
      null,
      2
    )
  );
});

server.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});
