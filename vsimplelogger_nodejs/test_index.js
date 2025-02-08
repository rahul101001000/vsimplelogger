const request = require('supertest');
const app = require('./index');


describe('POST /log', () => {
    it('should log action and return success message', async () => {
        const response = await request(app)
            .post('/log')
            .send({
                user: 'test_user',
                action: 'test_action',
                timestamp: '2023-10-01T12:34:56Z'
            })
            .set('Accept', 'application/json');

        expect(response.status).toBe(200);
        expect(response.body).toEqual({ message: 'Log recorded successfully' });
    });
});
