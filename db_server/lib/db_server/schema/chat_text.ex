defmodule DbServer.Schema.ChatText do
  use DbServer.AroundSchema

  @primary_key {:chat_id, :id, autogenerate: true}

  schema "chat_texts" do
    #belongs_to
    field :chat_text, :string
    #belongs_to
    #belongs_to

    timestamps()
  end
end