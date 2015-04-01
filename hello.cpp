#include <fstream>

int main() {
  std::ofstream out;
  out.open("cpp-out.txt");

  out << "Hello World!" << std::endl;

  out.close();
  return 0;
}
