return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'mrjones2014/codecompanion-ui.nvim',
    {
      'MeanderingProgrammer/render-markdown.nvim',
      ft = { 'codecompanion', 'codecompanion-ui' },
    },
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    strategies = {
      chat = { adapter = 'groq' },
      inline = { adapter = 'groq' },
      cmd = { adapter = 'groq' },
    },
    adapters = {
      http = {
        groq = function()
          return require('codecompanion.adapters').extend('openai', {
            name = 'Groq',
            url = 'https://api.groq.com/openai/v1/chat/completions',
            env = {
              api_key = os.getenv 'GROQ_API_KEY',
            },
            schema = {
              model = {
                default = 'llama-3.3-70b-versatile',
              },
              max_tokens = {
                default = 8192,
              },
              temperature = {
                default = 1,
              },
            },
            handlers = {
              form_messages = function(self, messages)
                for _, msg in ipairs(messages) do
                  msg.opts = nil
                  if msg.name then
                    msg.name = tostring(msg.name)
                  else
                    msg.name = nil
                  end

                  local supported_props = { role = true, content = true, name = true }
                  for prop in pairs(msg) do
                    if not supported_props[prop] then
                      msg[prop] = nil
                    end
                  end
                end
                return { messages = messages }
              end,
            },
          })
        end,
      },
    },
    extensions = {
      ui = {
        enabled = true,
        opts = {
          chat = {
            width = 0.35,
          },
        },
      },
    },
  },
}
