import { config } from "dotenv"
config()
console.log(process.env.API_KEY_OPENAI)
import { Configuration, OpenAIApi } from "openai"
import readline from 'readline'

const openai = new OpenAIApi(new Configuration({
    apiKey: process.env.API_KEY_OPENAI,    
}))
/*
openai.createChatCompletion({
    model: "gpt-3.5-turbo",
    messages: [
        {role: "user", content: "hello, how are you"}
    ]
}).then(response => {
   console.log(response.data.choices[0].message.content) 
})
*/
const ui = readline.createInterface({
    input: process.stdin,
    output: process.stdout
})
console.log("Type your question: ")
ui.on("line", async (text) => {    
    console.log(`You typed: ${text}`)
    const response = await openai.createChatCompletion({
        model: "gpt-3.5-turbo",
        messages: [
            {role: "user", content: `${text}`}
        ]
    }) 
    console.log("chatGPT: " + response.data.choices[0].message.content) 
    ui.prompt()
})

