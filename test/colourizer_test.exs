defmodule ColourizerTest do
  use ExUnit.Case
  doctest Colourizer

  test "Ensure entities are replaced" do
    assert Colourizer.encode_entities('<>&"\'') == ['&lt;', '&gt;', '&amp;', '&quot;', '&apos;']
  end

  test "Ensure non entities are not replaced" do
    assert Colourizer.encode_entities('abcdefghijklmnopqrstuvwxyz!@#$%^*()') ==
      [97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111,
      112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 33, 64, 35, 36, 37,
      94, 42, 40, 41]
  end

  test "Lexer test :atom" do
    assert Colourizer.lex("x = :some_atom") ==
      {:ok,
             [
               {:identifier, 1, 'x'},
               {:whitespace, 1, ' '},
               {:syntax, 1, '='},
               {:whitespace, 1, ' '},
               {:atom, 1, ':some_atom'}
             ]}
  end

  test "Lexer test arguments" do
    assert Colourizer.lex("def fx(arg, arg)") ==
      {:ok,
            [
              {:block, 1, 'def'},
              {:whitespace, 1, ' '},
              {:identifier, 1, 'fx'},
              {:argsbegin, 1, '('},
              {:identifier, 1, 'arg'},
              {:punctuation, 1, ','},
              {:whitespace, 1, ' '},
              {:identifier, 1, 'arg'},
              {:argsend, 1, ')'}
            ]}
  end

  test "Lexer test block" do
    assert Colourizer.lex("defmodule do end def") ==
      {:ok,
            [
              {:block, 1, 'defmodule'},
              {:whitespace, 1, ' '},
              {:block, 1, 'do'},
              {:whitespace, 1, ' '},
              {:block, 1, 'end'},
              {:whitespace, 1, ' '},
              {:block, 1, 'def'}
            ]}
  end

  test "Lexer test brackets" do
    assert Colourizer.lex("(){}[]") ==
      {:ok,
            [
              {:argsbegin, 1, '('},
              {:argsend, 1, ')'},
              {:brackets, 1, '{'},
              {:brackets, 1, '}'},
              {:brackets, 1, '['},
              {:brackets, 1, ']'}
            ]}
  end

  test "Lexer test comment" do
    assert Colourizer.lex("not_comment # comment\nnot_comment") ==
      {:ok,
            [
              {:identifier, 1, 'not_comment'},
              {:whitespace, 1, ' '},
              {:comment, 1, '# comment\n'},
              {:identifier, 2, 'not_comment'}
            ]}
  end

  test "Lexer test define" do
    assert Colourizer.lex("@define_something") ==
      {:ok,
            [
              {:define, 1, '@define_something'}
            ]}
  end

  test "Lexer test directive" do
    assert Colourizer.lex("require\nuse\nimport") ==
      {:ok,
            [
              {:directive, 1, 'require'},
              {:eol, 1, '\n'},
              {:directive, 2, 'use'},
              {:eol, 2, '\n'},
              {:directive, 3, 'import'}
            ]}
  end


end
