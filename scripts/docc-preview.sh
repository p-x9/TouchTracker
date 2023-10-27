TARGET='TouchTracker'
SCHEME='TouchTracker'

clean_build() {
  rm -rf ./.build
}

clean_xcbuild() {
  destination=$1
  xcodebuild -scheme "$SCHEME" \
    -destination "generic/platform=${destination}" \
    clean
}

generate_symbol_graphs() {
  destination=$1

  mkdir -p .build/symbol-graphs

  xcodebuild -scheme ${SCHEME} \
    -destination "generic/platform=${destination}" \
    OTHER_SWIFT_FLAGS="-emit-extension-block-symbols -emit-symbol-graph -emit-symbol-graph-dir ./.build/symbol-graphs"

  mv "./.build/symbol-graphs/$SCHEME.symbols.json" "./.build/symbol-graphs/${SCHEME}_${destination}.symbols.json"
}

clean_build
clean_xcbuild ios

generate_symbol_graphs ios

$(xcrun --find docc) preview \
  ./Sources/TouchTracker/TouchTracker.docc \
  --additional-symbol-graph-dir .build/symbol-graphs \
  --output-path "docs"
