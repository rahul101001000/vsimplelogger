const express = require('express');
const fs = require('fs');
const path = require('path');
const app = express();
app.use(express.json());

const LOG_DIR = './logs';
const LOG_RETENTION_DAYS = 7;

if (!fs.existsSync(LOG_DIR)) {
    fs.mkdirSync(LOG_DIR);
}

app.post('/log', (req, res) => {
    const { user, action, timestamp = new Date().toISOString() } = req.body;
    const logEntry = { user, action, timestamp };
    const logFile = path.join(LOG_DIR, `${new Date().toISOString().split('T')[0]}.log`);
    fs.appendFileSync(logFile, JSON.stringify(logEntry) + '\n');
    purgeOldLogs();
    res.json({ message: 'Log recorded successfully' });
});

function purgeOldLogs() {
    const cutoffDate = new Date(Date.now() - LOG_RETENTION_DAYS * 24 * 60 * 60 * 1000);
    fs.readdirSync(LOG_DIR).forEach(file => {
        const filePath = path.join(LOG_DIR, file);
        const fileDate = new Date(file.split('.')[0]);
        if (fileDate < cutoffDate) {
            fs.unlinkSync(filePath);
        }
    });
}

app.listen(3000, () => {
    console.log('Server is running on port 3000');
});
