#include "example.hpp"

example::example(const int& val)
  : m_val(val)
{}

const int& example::val() const
{
  return m_val;
}

void example::val(const int& val)
{
  m_val = val;
}
