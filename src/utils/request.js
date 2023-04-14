import axios from 'axios'

export default axios.create({
    // 线上部署需要更改
    baseURL:'http://127.0.0.1'
})