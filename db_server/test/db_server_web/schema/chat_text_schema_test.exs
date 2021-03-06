defmodule DbServerWeb.ChatTextSchemaTest do
  use ExUnit.Case, async: true

  use DbServer.DataCase
  use DbServer.AroundRepo

  # Chat text uses 2 many_to_many relationships.
  describe "chat text schema test." do
    @insert_params %{
      text: "Hello, World!"
    }

    @update_params %{
      text: "Updated one."
    }

    @insert_sender_params %{
      id: "sender_id",
      name: "sender_name",
      email: "sender@gmail.com",
      password: "Password123?",
      gender: 0,
      bio: "Howdy?",
      birthday: DateTime.utc_now()
    }

    @insert_recipient_params %{
      id: "recipient_id",
      name: "recipient_name",
      email: "recipient@gmail.com",
      password: "Password123?",
      gender: 0,
      bio: "Howdy?",
      birthday: DateTime.utc_now()
    }

    test "crud test." do
      assert {_, sender_struct} = Users.create(@insert_sender_params)
      assert {_, recipient_struct} = Users.create(@insert_recipient_params)
      assert {_, chat_struct} = ChatTexts.create(@insert_params, sender_struct, recipient_struct)
      assert @insert_params.text == chat_struct.text
      assert %ChatText{} = chat_text = ChatTexts.get(chat_struct.id)
      assert {:ok, %ChatText{} = chat_text} = ChatTexts.update(chat_text, @update_params)
      assert @update_params.text == chat_text.text
      assert {:ok, %ChatText{} = chat_text} = ChatTexts.delete(chat_text)
    end
  end
end